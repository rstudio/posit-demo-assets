# Public Radiation Monitoring Dashboard
# Interactive web application for public transparency

library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(DT)
library(plotly)
library(leaflet)
library(tidyverse)
library(lubridate)

# Source analysis functions
source("R/radiation_analysis.R")

# Load data
data_list <- load_radiation_data()
sensors_data <- data_list$sensors
weather_data <- data_list$weather
thresholds <- data_list$thresholds

# UI
ui <- dashboardPage(
  dashboardHeader(
    title = "  - Surveillance Radiologique Environnementale",
    titleWidth = 450
  ),
  
  dashboardSidebar(
    width = 300,
    sidebarMenu(
      menuItem("Vue d'ensemble", tabName = "overview", icon = icon("dashboard")),
      menuItem("Niveaux en temps réel", tabName = "realtime", icon = icon("activity")),
      menuItem("Carte des capteurs", tabName = "map", icon = icon("map-marker-alt")),
      menuItem("Tendances historiques", tabName = "trends", icon = icon("chart-line")),
      menuItem("Informations", tabName = "info", icon = icon("info-circle"))
    ),
    
    hr(),
    
    # Date range selector
    div(
      style = "padding: 15px;",
      h4("Période d'analyse", style = "color: white; font-size: 14px;"),
      dateRangeInput(
        "dateRange",
        "",
        start = max(sensors_data$timestamp) - days(7),
        end = max(sensors_data$timestamp),
        max = max(sensors_data$timestamp),
        language = "fr",
        format = "dd/mm/yyyy"
      )
    ),
    
    # Sensor filter
    div(
      style = "padding: 15px;",
      h4("Filtres", style = "color: white; font-size: 14px;"),
      checkboxGroupInput(
        "sensorTypes",
        "Types de capteurs:",
        choices = unique(sensors_data$sensor_type),
        selected = unique(sensors_data$sensor_type)
      )
    )
  ),
  
  dashboardBody(
    tags$head(
      tags$style(HTML("
        .content-wrapper, .right-side {
          background-color: #f4f4f4;
        }
        .box {
          border-top: 3px solid #3c8dbc;
        }
        .status-normal { color: #00a65a; font-weight: bold; }
        .status-investigation { color: #f39c12; font-weight: bold; }
        .status-alert { color: #dd4b39; font-weight: bold; }
      "))
    ),
    
    tabItems(
      # Overview Tab
      tabItem(
        tabName = "overview",
        fluidRow(
          valueBoxOutput("totalSensors"),
          valueBoxOutput("currentMax"),
          valueBoxOutput("overallStatus")
        ),
        
        fluidRow(
          box(
            title = "Résumé des Niveaux Actuels", 
            status = "primary", 
            solidHeader = TRUE,
            width = 8,
            plotlyOutput("overviewPlot")
          ),
          box(
            title = "Seuils Réglementaires",
            status = "info",
            solidHeader = TRUE,
            width = 4,
            tableOutput("thresholdTable")
          )
        ),
        
        fluidRow(
          box(
            title = "État des Capteurs",
            status = "primary",
            solidHeader = TRUE,
            width = 12,
            DT::dataTableOutput("sensorStatus")
          )
        )
      ),
      
      # Real-time Tab
      tabItem(
        tabName = "realtime",
        fluidRow(
          box(
            title = "Niveaux de Radiation en Temps Réel",
            status = "primary",
            solidHeader = TRUE,
            width = 12,
            plotlyOutput("realtimePlot", height = "500px")
          )
        ),
        
        fluidRow(
          box(
            title = "Dernières Mesures",
            status = "info",
            solidHeader = TRUE,
            width = 12,
            DT::dataTableOutput("latestReadings")
          )
        )
      ),
      
      # Map Tab
      tabItem(
        tabName = "map",
        fluidRow(
          box(
            title = "Carte du Réseau de Surveillance",
            status = "primary",
            solidHeader = TRUE,
            width = 12,
            leafletOutput("sensorMap", height = "600px")
          )
        )
      ),
      
      # Trends Tab
      tabItem(
        tabName = "trends",
        fluidRow(
          box(
            title = "Analyse des Tendances",
            status = "primary",
            solidHeader = TRUE,
            width = 8,
            plotlyOutput("trendsPlot", height = "400px")
          ),
          box(
            title = "Statistiques",
            status = "info",
            solidHeader = TRUE,
            width = 4,
            verbatimTextOutput("trendStats")
          )
        ),
        
        fluidRow(
          box(
            title = "Corrélation Météorologique",
            status = "primary",
            solidHeader = TRUE,
            width = 12,
            plotlyOutput("weatherCorrelation")
          )
        )
      ),
      
      # Info Tab
      tabItem(
        tabName = "info",
        fluidRow(
          box(
            title = "À propos de la surveillance radiologique",
            status = "primary",
            solidHeader = TRUE,
            width = 12,
            div(
              h3("Surveillance Environnementale Radiologique"),
              p("L'Autorité de sûreté nucléaire et de radioprotection ( ) surveille en permanence les niveaux de radiation autour des installations nucléaires françaises pour assurer la protection du public et de l'environnement."),
              
              h4("Comprendre les Mesures"),
              tags$ul(
                tags$li(strong("µSv/h"), " : Microsievert par heure - unité de mesure du débit de dose de radiation"),
                tags$li(strong("Radiation de fond"), " : Niveau naturel normal (0.05 - 0.20 µSv/h)"),
                tags$li(strong("Seuil d'investigation"), " : 0.50 µSv/h - nécessite une analyse approfondie"),
                tags$li(strong("Seuil d'alerte publique"), " : 1.00 µSv/h - mesures de protection envisagées")
              ),
              
              h4("Sources Naturelles de Radiation"),
              p("Les variations normales des niveaux de radiation peuvent être dues à :"),
              tags$ul(
                tags$li("Rayonnement cosmique (influence de l'altitude et conditions météorologiques)"),
                tags$li("Radon naturel (concentré par la pluie et conditions atmosphériques)"),
                tags$li("Radioactivité naturelle des roches et sols"),
                tags$li("Variations saisonnières")
              ),
              
              h4("Transparence et Accessibilité"),
              p("Cette interface publique est mise à jour automatiquement et fournit un accès transparent aux données de surveillance environnementale. Toutes les mesures sont validées selon les protocoles  ."),
              
              hr(),
              p(em("Dernière mise à jour des données: "), format(max(sensors_data$timestamp), "%d/%m/%Y %H:%M")),
              p(em("Contact  : surveillance.environnement@ .gouv.fr"))
            )
          )
        )
      )
    )
  )
)

# Server
server <- function(input, output, session) {
  
  # Reactive data filtering
  filtered_data <- reactive({
    sensors_data %>%
      filter(
        date(timestamp) >= input$dateRange[1],
        date(timestamp) <= input$dateRange[2],
        sensor_type %in% input$sensorTypes,
        status == "operational"
      )
  })
  
  # Value boxes
  output$totalSensors <- renderValueBox({
    operational_count <- sum(sensors_data$status == "operational")
    total_count <- nrow(unique(sensors_data[c("sensor_id")]))
    
    valueBox(
      value = paste(operational_count, "/", total_count),
      subtitle = "Capteurs Opérationnels",
      icon = icon("satellite-dish"),
      color = if (operational_count == total_count) "green" else "yellow"
    )
  })
  
  output$currentMax <- renderValueBox({
    latest_max <- filtered_data() %>%
      filter(timestamp >= max(timestamp) - hours(1)) %>%
      pull(radiation_level) %>%
      max(na.rm = TRUE)
    
    valueBox(
      value = paste(round(latest_max, 3), "µSv/h"),
      subtitle = "Niveau Maximum Actuel",
      icon = icon("radiation"),
      color = if (latest_max > 0.5) "red" else if (latest_max > 0.3) "yellow" else "green"
    )
  })
  
  output$overallStatus <- renderValueBox({
    alert_threshold <- thresholds$radiation_level[thresholds$threshold_type == "Public Alert"]
    investigation_threshold <- thresholds$radiation_level[thresholds$threshold_type == "Investigation Level"]
    
    current_readings <- filtered_data() %>%
      filter(timestamp >= max(timestamp) - hours(1)) %>%
      pull(radiation_level)
    
    max_current <- max(current_readings, na.rm = TRUE)
    
    status_text <- if (max_current >= alert_threshold) {
      "ALERTE"
    } else if (max_current >= investigation_threshold) {
      "SURVEILLANCE"
    } else {
      "NORMAL"
    }
    
    status_color <- if (max_current >= alert_threshold) {
      "red"
    } else if (max_current >= investigation_threshold) {
      "yellow"
    } else {
      "green"
    }
    
    valueBox(
      value = status_text,
      subtitle = "État Général",
      icon = icon("shield-alt"),
      color = status_color
    )
  })
  
  # Overview plot
  output$overviewPlot <- renderPlotly({
    plot_data <- filtered_data() %>%
      group_by(timestamp) %>%
      summarise(
        avg_radiation = mean(radiation_level, na.rm = TRUE),
        max_radiation = max(radiation_level, na.rm = TRUE),
        .groups = "drop"
      )
    
    p <- ggplot(plot_data, aes(x = timestamp)) +
      geom_line(aes(y = avg_radiation), color = "steelblue", size = 1) +
      geom_line(aes(y = max_radiation), color = "orange", alpha = 0.7) +
      geom_hline(yintercept = thresholds$radiation_level[thresholds$threshold_type == "Investigation Level"],
                 color = "orange", linetype = "dashed", alpha = 0.8) +
      geom_hline(yintercept = thresholds$radiation_level[thresholds$threshold_type == "Public Alert"],
                 color = "red", linetype = "dashed", alpha = 0.8) +
      labs(
        title = "Niveaux de Radiation - Réseau Complet",
        x = "Temps",
        y = "Niveau de Radiation (µSv/h)"
      ) +
      theme_minimal()
    
    ggplotly(p) %>%
      config(displayModeBar = FALSE)
  })
  
  # Threshold table
  output$thresholdTable <- renderTable({
    thresholds %>%
      select(threshold_type, radiation_level) %>%
      rename(
        "Type de Seuil" = threshold_type,
        "Niveau (µSv/h)" = radiation_level
      )
  })
  
  # Sensor status table
  output$sensorStatus <- DT::renderDataTable({
    latest_status <- filtered_data() %>%
      group_by(sensor_id) %>%
      filter(timestamp == max(timestamp)) %>%
      ungroup() %>%
      select(sensor_id, sensor_type, radiation_level, quality_flag, timestamp) %>%
      mutate(
        radiation_level = round(radiation_level, 4),
        status_class = case_when(
          radiation_level >= thresholds$radiation_level[thresholds$threshold_type == "Public Alert"] ~ "Alerte",
          radiation_level >= thresholds$radiation_level[thresholds$threshold_type == "Investigation Level"] ~ "Surveillance",
          TRUE ~ "Normal"
        )
      ) %>%
      rename(
        "Capteur" = sensor_id,
        "Type" = sensor_type,
        "Niveau (µSv/h)" = radiation_level,
        "Qualité" = quality_flag,
        "Dernière Mesure" = timestamp,
        "État" = status_class
      )
    
    DT::datatable(
      latest_status,
      options = list(pageLength = 10, scrollX = TRUE),
      rownames = FALSE
    ) %>%
      formatStyle(
        "État",
        backgroundColor = styleEqual(
          c("Normal", "Surveillance", "Alerte"),
          c("#d4edda", "#fff3cd", "#f8d7da")
        )
      )
  })
  
  # Real-time plot
  output$realtimePlot <- renderPlotly({
    recent_data <- filtered_data() %>%
      filter(timestamp >= max(timestamp) - hours(24))
    
    p <- ggplot(recent_data, aes(x = timestamp, y = radiation_level, color = sensor_id)) +
      geom_line(alpha = 0.7) +
      labs(
        title = "Niveaux de Radiation - 24 Dernières Heures",
        x = "Temps",
        y = "Niveau de Radiation (µSv/h)",
        color = "Capteur"
      ) +
      theme_minimal() +
      theme(legend.position = "none")
    
    ggplotly(p) %>%
      config(displayModeBar = FALSE)
  })
  
  # Latest readings table
  output$latestReadings <- DT::renderDataTable({
    latest_readings <- filtered_data() %>%
      filter(timestamp >= max(timestamp) - minutes(30)) %>%
      select(timestamp, sensor_id, radiation_level, quality_flag) %>%
      mutate(radiation_level = round(radiation_level, 4)) %>%
      arrange(desc(timestamp)) %>%
      rename(
        "Horodatage" = timestamp,
        "Capteur" = sensor_id,
        "Niveau (µSv/h)" = radiation_level,
        "Qualité" = quality_flag
      )
    
    DT::datatable(
      latest_readings,
      options = list(pageLength = 15, scrollX = TRUE),
      rownames = FALSE
    )
  })
  
  # Sensor map
  output$sensorMap <- renderLeaflet({
    map_data <- filtered_data() %>%
      group_by(sensor_id) %>%
      filter(timestamp == max(timestamp)) %>%
      ungroup()
    
    create_sensor_map(map_data)
  })
  
  # Trends plot
  output$trendsPlot <- renderPlotly({
    trend_data <- filtered_data() %>%
      group_by(date = as.Date(timestamp)) %>%
      summarise(
        avg_radiation = mean(radiation_level, na.rm = TRUE),
        min_radiation = min(radiation_level, na.rm = TRUE),
        max_radiation = max(radiation_level, na.rm = TRUE),
        .groups = "drop"
      )
    
    p <- ggplot(trend_data, aes(x = date)) +
      geom_ribbon(aes(ymin = min_radiation, ymax = max_radiation), alpha = 0.3, fill = "lightblue") +
      geom_line(aes(y = avg_radiation), color = "steelblue", size = 1) +
      labs(
        title = "Tendances des Niveaux de Radiation",
        x = "Date",
        y = "Niveau de Radiation (µSv/h)"
      ) +
      theme_minimal()
    
    ggplotly(p) %>%
      config(displayModeBar = FALSE)
  })
  
  # Trend statistics
  output$trendStats <- renderText({
    stats <- filtered_data() %>%
      summarise(
        moyenne = round(mean(radiation_level, na.rm = TRUE), 4),
        mediane = round(median(radiation_level, na.rm = TRUE), 4),
        minimum = round(min(radiation_level, na.rm = TRUE), 4),
        maximum = round(max(radiation_level, na.rm = TRUE), 4),
        ecart_type = round(sd(radiation_level, na.rm = TRUE), 4)
      )
    
    paste(
      "Statistiques de la période sélectionnée:\n\n",
      "Moyenne:", stats$moyenne, "µSv/h\n",
      "Médiane:", stats$mediane, "µSv/h\n",
      "Minimum:", stats$minimum, "µSv/h\n",
      "Maximum:", stats$maximum, "µSv/h\n",
      "Écart-type:", stats$ecart_type, "µSv/h"
    )
  })
  
  # Weather correlation plot
  output$weatherCorrelation <- renderPlotly({
    if (nrow(weather_data) > 0) {
      merged_data <- filtered_data() %>%
        left_join(weather_data, by = "timestamp") %>%
        filter(!is.na(precipitation))
      
      p <- ggplot(merged_data, aes(x = precipitation, y = radiation_level)) +
        geom_point(alpha = 0.3, color = "steelblue") +
        geom_smooth(method = "lm", color = "red", se = TRUE) +
        labs(
          title = "Corrélation: Niveaux de Radiation vs Précipitations",
          x = "Précipitations (mm)",
          y = "Niveau de Radiation (µSv/h)"
        ) +
        theme_minimal()
      
      ggplotly(p) %>%
        config(displayModeBar = FALSE)
    }
  })
}

# Run the application
shinyApp(ui = ui, server = server)