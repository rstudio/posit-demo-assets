# SovereignWealth Capital - Portfolio API
# ========================================
# REST API for portfolio data access and risk predictions
# This project contains synthetic data and analysis created for demonstration purposes only.

library(plumber)
library(tidyverse)
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

# Load ML model if available
model_loaded <- FALSE
if (file.exists("ml/risk_prediction_model.rds")) {
  source("ml/model_utils.R")
  risk_model <- load_risk_model()
  model_loaded <- TRUE
}

#* @apiTitle SovereignWealth Capital Portfolio API
#* @apiDescription REST API for accessing portfolio data and generating risk predictions. This project contains synthetic data and analysis created for demonstration purposes only.
#* @apiVersion 1.0.0

#* Health check endpoint
#* @get /health
#* @serializer unboxedJSON
function() {
  list(
    status = "healthy",
    timestamp = Sys.time(),
    message = "SovereignWealth Capital API is running"
  )
}

#* Get portfolio summary
#* @get /portfolio/summary
#* @serializer unboxedJSON
function() {
  total_value <- sum(holdings$market_value, na.rm = TRUE)

  list(
    total_value = total_value,
    total_holdings = nrow(holdings),
    asset_classes = n_distinct(holdings$asset_class),
    last_updated = max(performance$month_end, na.rm = TRUE)
  )
}

#* Get all holdings
#* @get /portfolio/holdings
#* @param asset_class:str Optional: Filter by asset class
#* @serializer json
function(asset_class = NULL) {
  result <- holdings

  if (!is.null(asset_class)) {
    result <- result |> filter(asset_class == !!asset_class)
  }

  result |>
    select(investment_id, investment_name, asset_class, sector,
           market_value, risk_rating, acquisition_date) |>
    mutate(acquisition_date = as.character(acquisition_date))
}

#* Get holdings by ID
#* @get /portfolio/holdings/<id>
#* @param id:str Investment ID
#* @serializer unboxedJSON
function(id) {
  holding <- holdings |>
    filter(investment_id == id)

  if (nrow(holding) == 0) {
    stop("Investment not found")
  }

  # Get performance data
  perf <- performance |>
    filter(investment_id == id, !is.na(monthly_return)) |>
    arrange(desc(month_end)) |>
    head(12)

  list(
    investment = holding |> mutate(acquisition_date = as.character(acquisition_date)),
    recent_performance = perf |> mutate(month_end = as.character(month_end))
  )
}

#* Get portfolio allocation
#* @get /portfolio/allocation
#* @serializer json
function() {
  holdings |>
    group_by(asset_class) |>
    summarise(
      holdings_count = n(),
      market_value = sum(market_value, na.rm = TRUE),
      allocation_pct = market_value / sum(holdings$market_value, na.rm = TRUE) * 100,
      .groups = "drop"
    ) |>
    arrange(desc(market_value))
}

#* Get performance data
#* @get /portfolio/performance
#* @param start_date:str Optional: Start date (YYYY-MM-DD)
#* @param end_date:str Optional: End date (YYYY-MM-DD)
#* @serializer json
function(start_date = NULL, end_date = NULL) {
  # Calculate portfolio-level performance
  result <- performance |>
    left_join(holdings |> select(investment_id, market_value), by = "investment_id") |>
    filter(!is.na(monthly_return)) |>
    group_by(month_end) |>
    summarise(
      weighted_return = weighted.mean(monthly_return, market_value, na.rm = TRUE),
      .groups = "drop"
    ) |>
    mutate(cumulative_return = cumprod(1 + weighted_return) - 1)

  # Filter by date range if provided
  if (!is.null(start_date)) {
    result <- result |> filter(month_end >= as.Date(start_date))
  }
  if (!is.null(end_date)) {
    result <- result |> filter(month_end <= as.Date(end_date))
  }

  result |> mutate(month_end = as.character(month_end))
}

#* Get transactions
#* @get /transactions
#* @param transaction_type:str Optional: Filter by type (Buy, Sell, Distribution, Reinvestment)
#* @param limit:int Optional: Limit number of results (default: 100)
#* @serializer json
function(transaction_type = NULL, limit = 100) {
  result <- transactions |> filter(!is.na(amount))

  if (!is.null(transaction_type)) {
    result <- result |> filter(transaction_type == !!transaction_type)
  }

  result |>
    arrange(desc(transaction_date)) |>
    head(as.integer(limit)) |>
    mutate(transaction_date = as.character(transaction_date))
}

#* Predict risk rating for investment
#* @post /predict/risk
#* @param asset_class:str Asset class of investment
#* @param volatility:double Historical volatility
#* @param avg_return:double Average return
#* @param max_drawdown:double Maximum drawdown
#* @param positive_months:double Proportion of positive months
#* @param return_consistency:double Return consistency metric
#* @param days_held:int Days held
#* @param current_yield:double Current yield
#* @param market_value:double Market value
#* @serializer unboxedJSON
function(asset_class, volatility, avg_return, max_drawdown,
         positive_months, return_consistency, days_held,
         current_yield, market_value) {

  if (!model_loaded) {
    stop("Risk prediction model not available. Please train the model first.")
  }

  # Create input data frame
  new_data <- tibble(
    asset_class = factor(asset_class,
                        levels = levels(holdings$asset_class)),
    volatility = as.numeric(volatility),
    avg_return = as.numeric(avg_return),
    max_drawdown = as.numeric(max_drawdown),
    positive_months = as.numeric(positive_months),
    return_consistency = as.numeric(return_consistency),
    days_held = as.numeric(days_held),
    current_yield = as.numeric(current_yield),
    market_value = as.numeric(market_value)
  )

  # Make prediction
  prediction <- predict(risk_model, new_data)
  probabilities <- predict(risk_model, new_data, type = "prob")

  list(
    predicted_risk = as.character(prediction$.pred_class),
    probabilities = as.list(probabilities[1, ]),
    input_features = as.list(new_data)
  )
}

#* Get model information
#* @get /model-info
#* @serializer unboxedJSON
function() {
  if (!model_loaded) {
    return(list(
      status = "Model not loaded",
      message = "Please train the model using ml/train_model.R"
    ))
  }

  metrics <- get_model_metrics()
  importance <- get_feature_importance()

  list(
    model_type = "Random Forest Classifier",
    target = "Investment Risk Rating",
    accuracy = metrics |> filter(.metric == "accuracy") |> pull(.estimate),
    feature_importance = importance |> head(5) |> as.list(),
    status = "ready"
  )
}

#* Sample data endpoint
#* @get /data
#* @param type:str Data type: holdings, performance, or transactions
#* @param limit:int Number of records (default: 10)
#* @serializer json
function(type = "holdings", limit = 10) {
  limit <- as.integer(limit)

  result <- switch(type,
    "holdings" = holdings |> head(limit) |>
      mutate(acquisition_date = as.character(acquisition_date)),
    "performance" = performance |> head(limit) |>
      mutate(month_end = as.character(month_end)),
    "transactions" = transactions |> head(limit) |>
      mutate(transaction_date = as.character(transaction_date)),
    stop("Invalid type. Choose: holdings, performance, or transactions")
  )

  result
}
