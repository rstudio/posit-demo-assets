# SovereignWealth Capital - Portfolio Performance Dashboard
# ===========================================================
# Interactive dashboard for investment portfolio monitoring and analysis

library(shiny)
library(bslib)
library(tidyverse)
library(plotly)
library(DT)
library(gt)
library(scales)
library(lubridate)

# Check if synthetic data exists
if (!file.exists("data/synthetic-portfolio-holdings.csv")) {
  cat("Synthetic data not found. Generating data...\n")
  source("data/generate_data.R")
}

# Load data
holdings <- read_csv("data/synthetic-portfolio-holdings.csv", show_col_types = FALSE)
performance <- read_csv("data/synthetic-performance-history.csv", show_col_types = FALSE)
transactions <- read_csv("data/synthetic-transactions.csv", show_col_types = FALSE)
benchmarks <- read_csv("data/synthetic-benchmarks.csv", show_col_types = FALSE)

# Load ML model if available
model_loaded <- FALSE
if (file.exists("ml/risk_prediction_model.rds")) {
  source("ml/model_utils.R")
  risk_model <- load_risk_model()
  model_loaded <- TRUE
}

# Calculate portfolio metrics
total_value <- sum(holdings$market_value, na.rm = TRUE)
num_holdings <- nrow(holdings)
portfolio_performance <- performance |>
  left_join(holdings |> select(investment_id, asset_class, market_value), by = "investment_id") |>
  filter(!is.na(monthly_return)) |>
  arrange(investment_id, month_end) |>
  group_by(month_end) |>
  summarise(weighted_return = weighted.mean(monthly_return, market_value, na.rm = TRUE), .groups = "drop") |>
  mutate(cumulative_return = cumprod(1 + weighted_return) - 1)

ytd_return <- portfolio_performance |>
  filter(year(month_end) == year(today())) |>
  summarise(ytd = prod(1 + weighted_return) - 1) |>
  pull(ytd)

# UI
ui <- page_navbar(
  title = "Portfolio Performance Dashboard",
  theme = bs_theme(brand = "_brand.yml"),
  fillable = TRUE,

  # Overview Tab
  nav_panel(
    "Overview",
    layout_columns(
      col_widths = c(3, 3, 3, 3),
      value_box(
        title = "Total Portfolio Value",
        value = dollar(total_value, accuracy = 1),
        theme = "primary"
      ),
      value_box(
        title = "Total Holdings",
        value = num_holdings,
        theme = "success"
      ),
      value_box(
        title = "YTD Return",
        value = percent(ytd_return, accuracy = 0.1),
        theme = if_else(ytd_return > 0, "success", "danger")
      ),
      value_box(
        title = "Asset Classes",
        value = n_distinct(holdings$asset_class),
        theme = "info"
      )
    ),

    layout_columns(
      col_widths = c(6, 6),
      card(
        card_header("Portfolio Allocation"),
        plotlyOutput("allocation_plot", height = "400px")
      ),
      card(
        card_header("Cumulative Performance"),
        plotlyOutput("performance_plot", height = "400px")
      )
    ),

    card(
      card_header("Holdings by Asset Class"),
      DTOutput("holdings_table")
    )
  ),

  # Performance Tab
  nav_panel(
    "Performance",
    layout_columns(
      col_widths = c(12),
      card(
        card_header("Rolling 12-Month Returns"),
        plotlyOutput("rolling_returns_plot", height = "400px")
      )
    ),
    layout_columns(
      col_widths = c(6, 6),
      card(
        card_header("Returns by Asset Class"),
        plotlyOutput("asset_returns_plot", height = "400px")
      ),
      card(
        card_header("Risk-Return Profile"),
        plotlyOutput("risk_return_plot", height = "400px")
      )
    )
  ),

  # Transactions Tab
  nav_panel(
    "Transactions",
    layout_columns(
      col_widths = c(12),
      card(
        card_header("Transaction History"),
        layout_sidebar(
          sidebar = sidebar(
            selectInput("trans_type", "Transaction Type:",
                       choices = c("All", sort(unique(transactions$transaction_type))),
                       selected = "All"),
            dateRangeInput("trans_dates", "Date Range:",
                          start = min(transactions$transaction_date, na.rm = TRUE),
                          end = max(transactions$transaction_date, na.rm = TRUE))
          ),
          DTOutput("transactions_table")
        )
      )
    ),
    layout_columns(
      col_widths = c(12),
      card(
        card_header("Transaction Volume Over Time"),
        plotlyOutput("transactions_plot", height = "400px")
      )
    )
  ),

  # Risk Analysis Tab
  nav_panel(
    "Risk Analysis",
    layout_columns(
      col_widths = c(6, 6),
      card(
        card_header("Risk Distribution"),
        plotlyOutput("risk_distribution_plot", height = "400px")
      ),
      card(
        card_header("Volatility by Asset Class"),
        plotlyOutput("volatility_plot", height = "400px")
      )
    ),
    card(
      card_header("Risk Metrics by Asset Class"),
      gt_output("risk_metrics_table")
    )
  ),

  # Data Quality Tab
  nav_panel(
    "Data Quality",
    layout_columns(
      col_widths = c(12),
      card(
        card_header("Missing Data Summary"),
        gt_output("missing_data_table")
      )
    ),
    layout_columns(
      col_widths = c(12),
      card(
        card_header("Data Completeness"),
        plotlyOutput("completeness_plot", height = "400px")
      )
    )
  ),

  nav_spacer(),

  nav_item(
    tags$div(
      style = "padding: 10px;",
      tags$em("This project contains synthetic data and analysis created for demonstration purposes only.")
    )
  )
)

# Server
server <- function(input, output, session) {

  # Overview Tab Outputs
  output$allocation_plot <- renderPlotly({
    portfolio_summary <- holdings |>
      group_by(asset_class) |>
      summarise(value = sum(market_value, na.rm = TRUE), .groups = "drop")

    plot_ly(portfolio_summary,
            labels = ~asset_class,
            values = ~value,
            type = "pie",
            hole = 0.4,
            marker = list(
              colors = c("#006B7D", "#2D5016", "#D4A574", "#B85C38", "#4A5568", "#A0AEC0", "#1A1A1A")
            ),
            textposition = "outside",
            textinfo = "label+percent") |>
      layout(showlegend = TRUE)
  })

  output$performance_plot <- renderPlotly({
    plot_ly(portfolio_performance,
            x = ~month_end,
            y = ~cumulative_return * 100,
            type = "scatter",
            mode = "lines",
            line = list(color = "#006B7D", width = 3),
            fill = "tozeroy",
            fillcolor = "rgba(0, 107, 125, 0.2)") |>
      layout(
        xaxis = list(title = "Date"),
        yaxis = list(title = "Cumulative Return (%)", tickformat = ".1f"),
        hovermode = "x"
      )
  })

  output$holdings_table <- renderDT({
    holdings |>
      select(investment_name, asset_class, sector, market_value, risk_rating) |>
      datatable(
        options = list(pageLength = 10, dom = "tip"),
        rownames = FALSE
      ) |>
      formatCurrency("market_value", digits = 0)
  })

  # Performance Tab Outputs
  output$rolling_returns_plot <- renderPlotly({
    rolling_data <- portfolio_performance |>
      mutate(rolling_12m = zoo::rollapplyr(weighted_return, 12, function(x) prod(1 + x) - 1, fill = NA))

    plot_ly(rolling_data |> filter(!is.na(rolling_12m)),
            x = ~month_end,
            y = ~rolling_12m * 100,
            type = "scatter",
            mode = "lines",
            line = list(color = "#006B7D", width = 2),
            fill = "tozeroy",
            fillcolor = "rgba(0, 107, 125, 0.2)") |>
      layout(
        xaxis = list(title = "Date"),
        yaxis = list(title = "12-Month Return (%)", tickformat = ".1f"),
        hovermode = "x"
      )
  })

  output$asset_returns_plot <- renderPlotly({
    asset_returns <- performance |>
      left_join(holdings |> select(investment_id, asset_class), by = "investment_id") |>
      filter(!is.na(monthly_return)) |>
      group_by(asset_class, month_end) |>
      summarise(avg_return = mean(monthly_return, na.rm = TRUE), .groups = "drop") |>
      group_by(asset_class) |>
      summarise(ann_return = (prod(1 + avg_return) ^ (12 / n()) - 1) * 100, .groups = "drop")

    plot_ly(asset_returns,
            x = ~reorder(asset_class, ann_return),
            y = ~ann_return,
            type = "bar",
            marker = list(color = "#006B7D")) |>
      layout(
        xaxis = list(title = ""),
        yaxis = list(title = "Annualized Return (%)"),
        showlegend = FALSE
      )
  })

  output$risk_return_plot <- renderPlotly({
    asset_risk_return <- performance |>
      left_join(holdings |> select(investment_id, asset_class, market_value), by = "investment_id") |>
      filter(!is.na(monthly_return)) |>
      group_by(asset_class) |>
      summarise(
        avg_return = mean(monthly_return, na.rm = TRUE) * 12 * 100,
        volatility = sd(monthly_return, na.rm = TRUE) * sqrt(12) * 100,
        market_value = sum(market_value, na.rm = TRUE),
        .groups = "drop"
      )

    plot_ly(asset_risk_return,
            x = ~volatility,
            y = ~avg_return,
            type = "scatter",
            mode = "markers",
            marker = list(
              size = ~sqrt(market_value) / 500,
              color = "#006B7D",
              opacity = 0.7,
              line = list(color = "#FFFFFF", width = 2)
            ),
            text = ~asset_class,
            hovertemplate = paste(
              "<b>%{text}</b><br>",
              "Return: %{y:.1f}%<br>",
              "Volatility: %{x:.1f}%<br>",
              "<extra></extra>"
            )) |>
      layout(
        xaxis = list(title = "Volatility (%)"),
        yaxis = list(title = "Return (%)"),
        showlegend = FALSE
      )
  })

  # Transactions Tab Outputs
  transactions_filtered <- reactive({
    trans <- transactions |>
      filter(!is.na(amount))

    if (input$trans_type != "All") {
      trans <- trans |> filter(transaction_type == input$trans_type)
    }

    trans |>
      filter(transaction_date >= input$trans_dates[1],
             transaction_date <= input$trans_dates[2])
  })

  output$transactions_table <- renderDT({
    transactions_filtered() |>
      arrange(desc(transaction_date)) |>
      select(transaction_date, transaction_type, amount, investment_id) |>
      datatable(
        options = list(pageLength = 15, dom = "tip"),
        rownames = FALSE
      ) |>
      formatCurrency("amount", digits = 0)
  })

  output$transactions_plot <- renderPlotly({
    trans_summary <- transactions |>
      filter(!is.na(amount)) |>
      mutate(year = year(transaction_date)) |>
      group_by(year, transaction_type) |>
      summarise(total = sum(amount, na.rm = TRUE), .groups = "drop")

    plot_ly(trans_summary,
            x = ~year,
            y = ~total / 1e6,
            color = ~transaction_type,
            type = "bar",
            colors = c("#006B7D", "#2D5016", "#D4A574", "#B85C38")) |>
      layout(
        barmode = "stack",
        xaxis = list(title = "Year"),
        yaxis = list(title = "Amount (Millions)"),
        legend = list(title = list(text = "Transaction Type"))
      )
  })

  # Risk Analysis Tab Outputs
  output$risk_distribution_plot <- renderPlotly({
    risk_dist <- holdings |>
      count(risk_rating) |>
      mutate(risk_rating = factor(risk_rating,
                                  levels = c("Low", "Medium-Low", "Medium", "Medium-High", "High")))

    plot_ly(risk_dist,
            x = ~risk_rating,
            y = ~n,
            type = "bar",
            marker = list(
              color = c("#2D5016", "#D4A574", "#006B7D", "#B85C38", "#4A5568")
            )) |>
      layout(
        xaxis = list(title = "Risk Rating"),
        yaxis = list(title = "Number of Holdings"),
        showlegend = FALSE
      )
  })

  output$volatility_plot <- renderPlotly({
    volatility_data <- performance |>
      left_join(holdings |> select(investment_id, asset_class), by = "investment_id") |>
      filter(!is.na(monthly_return)) |>
      group_by(asset_class) |>
      summarise(volatility = sd(monthly_return, na.rm = TRUE) * sqrt(12) * 100, .groups = "drop")

    plot_ly(volatility_data,
            x = ~reorder(asset_class, volatility),
            y = ~volatility,
            type = "bar",
            marker = list(color = "#B85C38")) |>
      layout(
        xaxis = list(title = ""),
        yaxis = list(title = "Annualized Volatility (%)"),
        showlegend = FALSE
      )
  })

  output$risk_metrics_table <- render_gt({
    risk_metrics <- performance |>
      left_join(holdings |> select(investment_id, asset_class), by = "investment_id") |>
      filter(!is.na(monthly_return)) |>
      group_by(asset_class) |>
      summarise(
        `Annualized Return` = (prod(1 + mean(monthly_return, na.rm = TRUE)) ^ 12 - 1),
        Volatility = sd(monthly_return, na.rm = TRUE) * sqrt(12),
        `Sharpe Ratio` = `Annualized Return` / Volatility,
        `Max Monthly Loss` = min(monthly_return, na.rm = TRUE),
        .groups = "drop"
      )

    risk_metrics |>
      gt() |>
      cols_label(asset_class = "Asset Class") |>
      fmt_percent(columns = c(`Annualized Return`, Volatility, `Max Monthly Loss`), decimals = 1) |>
      fmt_number(columns = `Sharpe Ratio`, decimals = 2)
  })

  # Data Quality Tab Outputs
  output$missing_data_table <- render_gt({
    missing_summary <- tibble(
      Dataset = c("Holdings", "Performance", "Transactions", "Benchmarks"),
      Records = c(nrow(holdings), nrow(performance), nrow(transactions), nrow(benchmarks)),
      `Missing Values` = c(
        sum(is.na(holdings)),
        sum(is.na(performance)),
        sum(is.na(transactions)),
        sum(is.na(benchmarks))
      )
    ) |>
      mutate(`Completeness %` = round(100 - (100 * `Missing Values` / (Records * c(ncol(holdings), ncol(performance), ncol(transactions), ncol(benchmarks)))), 1))

    missing_summary |>
      gt() |>
      tab_header(title = "Data Quality Overview") |>
      fmt_number(columns = c(Records, `Missing Values`), decimals = 0)
  })

  output$completeness_plot <- renderPlotly({
    completeness_data <- tibble(
      Dataset = c("Holdings", "Performance", "Transactions", "Benchmarks"),
      Completeness = c(
        100 - (100 * sum(is.na(holdings)) / (nrow(holdings) * ncol(holdings))),
        100 - (100 * sum(is.na(performance)) / (nrow(performance) * ncol(performance))),
        100 - (100 * sum(is.na(transactions)) / (nrow(transactions) * ncol(transactions))),
        100 - (100 * sum(is.na(benchmarks)) / (nrow(benchmarks) * ncol(benchmarks)))
      )
    )

    plot_ly(completeness_data,
            x = ~Dataset,
            y = ~Completeness,
            type = "bar",
            marker = list(color = "#2D5016")) |>
      layout(
        xaxis = list(title = ""),
        yaxis = list(title = "Completeness (%)", range = c(0, 100)),
        showlegend = FALSE
      )
  })
}

# Run app
shinyApp(ui, server)
