# Radiation Analysis Script
# Anomaly Detection and Statistical Analysis for Environmental Monitoring

library(tidyverse)
library(lubridate)
library(forecast)
library(plotly)
library(leaflet)
library(DT)

# Load data
load_radiation_data <- function() {
  sensors <- read_csv("data/flamanville_sensors_2024.csv", show_col_types = FALSE)
  weather <- read_csv("data/meteorological_2024.csv", show_col_types = FALSE)
  thresholds <- read_csv("data/regulatory_thresholds.csv", show_col_types = FALSE)
  locations <- read_csv("data/sensor_locations.csv", show_col_types = FALSE)
  
  list(
    sensors = sensors,
    weather = weather,
    thresholds = thresholds,
    locations = locations
  )
}

# Anomaly detection using statistical process control
detect_anomalies <- function(data, threshold_sigma = 3) {
  data %>%
    filter(status == "operational", quality_flag != "invalid") %>%
    group_by(sensor_id) %>%
    arrange(timestamp) %>%
    mutate(
      rolling_mean = zoo::rollmean(radiation_level, k = 24, fill = NA, align = "center"),
      rolling_sd = zoo::rollapply(radiation_level, width = 24, FUN = sd, fill = NA, align = "center"),
      z_score = abs(radiation_level - rolling_mean) / rolling_sd,
      is_anomaly = z_score > threshold_sigma & !is.na(z_score),
      anomaly_type = case_when(
        is_anomaly & radiation_level > rolling_mean ~ "spike",
        is_anomaly & radiation_level < rolling_mean ~ "drop",
        TRUE ~ "normal"
      )
    ) %>%
    ungroup()
}

# Calculate summary statistics
calculate_summary_stats <- function(data, thresholds) {
  current_levels <- data %>%
    filter(timestamp >= max(timestamp) - hours(1)) %>%
    group_by(sensor_id) %>%
    summarise(
      current_level = mean(radiation_level, na.rm = TRUE),
      .groups = "drop"
    )
  
  alert_threshold <- thresholds %>% 
    filter(threshold_type == "Public Alert") %>% 
    pull(radiation_level)
  
  investigation_threshold <- thresholds %>% 
    filter(threshold_type == "Investigation Level") %>% 
    pull(radiation_level)
  
  list(
    total_sensors = n_distinct(data$sensor_id),
    operational_sensors = sum(data$status == "operational"),
    current_max = max(current_levels$current_level, na.rm = TRUE),
    sensors_above_investigation = sum(current_levels$current_level > investigation_threshold, na.rm = TRUE),
    sensors_above_alert = sum(current_levels$current_level > alert_threshold, na.rm = TRUE),
    avg_radiation_24h = data %>% 
      filter(timestamp >= max(timestamp) - hours(24)) %>% 
      summarise(avg = mean(radiation_level, na.rm = TRUE)) %>% 
      pull(avg)
  )
}

# Create time series visualization
create_timeseries_plot <- function(data, sensor_ids = NULL, show_weather = FALSE) {
  if (is.null(sensor_ids)) {
    plot_data <- data %>%
      group_by(timestamp) %>%
      summarise(
        avg_radiation = mean(radiation_level, na.rm = TRUE),
        max_radiation = max(radiation_level, na.rm = TRUE),
        min_radiation = min(radiation_level, na.rm = TRUE),
        .groups = "drop"
      )
    
    p <- ggplot(plot_data, aes(x = timestamp)) +
      geom_ribbon(aes(ymin = min_radiation, ymax = max_radiation), alpha = 0.3, fill = "blue") +
      geom_line(aes(y = avg_radiation), color = "darkblue", size = 1) +
      labs(
        title = "Average Radiation Levels - All Sensors",
        subtitle = "Blue band shows min-max range across all sensors",
        x = "Time",
        y = "Radiation Level (µSv/h)"
      )
  } else {
    plot_data <- data %>% filter(sensor_id %in% sensor_ids)
    
    p <- ggplot(plot_data, aes(x = timestamp, y = radiation_level, color = sensor_id)) +
      geom_line(alpha = 0.7) +
      labs(
        title = paste("Radiation Levels -", length(sensor_ids), "Selected Sensors"),
        x = "Time",
        y = "Radiation Level (µSv/h)",
        color = "Sensor ID"
      )
  }
  
  # Add regulatory thresholds
  thresholds <- read_csv("data/regulatory_thresholds.csv", show_col_types = FALSE)
  
  p <- p +
    geom_hline(yintercept = thresholds$radiation_level[thresholds$threshold_type == "Investigation Level"], 
               color = "orange", linetype = "dashed", alpha = 0.8) +
    geom_hline(yintercept = thresholds$radiation_level[thresholds$threshold_type == "Public Alert"], 
               color = "red", linetype = "dashed", alpha = 0.8) +
    theme_minimal() +
    theme(legend.position = "bottom")
  
  return(p)
}

# Create spatial map of sensors
create_sensor_map <- function(sensors_data, weather_data = NULL) {
  # Get latest readings for each sensor
  latest_readings <- sensors_data %>%
    group_by(sensor_id) %>%
    filter(timestamp == max(timestamp)) %>%
    ungroup()
  
  # Create color palette based on radiation levels
  pal <- colorNumeric(
    palette = c("green", "yellow", "orange", "red"),
    domain = latest_readings$radiation_level
  )
  
  # Create base map
  map <- leaflet(latest_readings) %>%
    addTiles() %>%
    setView(lng = -1.86, lat = 49.535, zoom = 12) %>%
    addCircleMarkers(
      lng = ~longitude,
      lat = ~latitude,
      radius = ~10 + radiation_level * 20,
      color = ~pal(radiation_level),
      fillOpacity = 0.7,
      popup = ~paste(
        "<b>Sensor:</b>", sensor_id, "<br>",
        "<b>Type:</b>", sensor_type, "<br>",
        "<b>Current Level:</b>", round(radiation_level, 4), "µSv/h<br>",
        "<b>Status:</b>", status, "<br>",
        "<b>Quality:</b>", quality_flag
      )
    ) %>%
    addLegend(
      pal = pal,
      values = ~radiation_level,
      title = "Radiation Level<br>(µSv/h)",
      position = "bottomright"
    )
  
  return(map)
}

# Weather correlation analysis
analyze_weather_correlation <- function(sensors_data, weather_data) {
  # Merge datasets
  merged_data <- sensors_data %>%
    left_join(weather_data, by = "timestamp") %>%
    filter(!is.na(temperature), status == "operational")
  
  # Calculate correlations
  correlations <- merged_data %>%
    select(radiation_level, temperature, humidity, wind_speed, precipitation, atmospheric_pressure) %>%
    cor(use = "complete.obs") %>%
    as.data.frame() %>%
    rownames_to_column("variable") %>%
    filter(variable == "radiation_level") %>%
    select(-radiation_level) %>%
    pivot_longer(-variable, names_to = "weather_var", values_to = "correlation") %>%
    arrange(desc(abs(correlation)))
  
  return(correlations)
}

# Generate anomaly report
generate_anomaly_report <- function(anomaly_data) {
  anomalies <- anomaly_data %>%
    filter(is_anomaly) %>%
    select(timestamp, sensor_id, radiation_level, rolling_mean, z_score, anomaly_type) %>%
    arrange(desc(timestamp))
  
  if (nrow(anomalies) == 0) {
    return("No anomalies detected in the current dataset.")
  }
  
  summary <- anomalies %>%
    group_by(anomaly_type) %>%
    summarise(
      count = n(),
      avg_deviation = mean(abs(radiation_level - rolling_mean), na.rm = TRUE),
      max_z_score = max(z_score, na.rm = TRUE),
      .groups = "drop"
    )
  
  list(
    anomalies = anomalies,
    summary = summary,
    total_anomalies = nrow(anomalies)
  )
}

# Export functions for use in reports and apps
if (!interactive()) {
  cat("Radiation analysis functions loaded successfully.\n")
  cat("Available functions:\n")
  cat("- load_radiation_data()\n")
  cat("- detect_anomalies()\n")
  cat("- calculate_summary_stats()\n")
  cat("- create_timeseries_plot()\n")
  cat("- create_sensor_map()\n")
  cat("- analyze_weather_correlation()\n")
  cat("- generate_anomaly_report()\n")
}