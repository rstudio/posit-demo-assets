# SovereignWealth Capital - Investment Risk Prediction Model
# ===========================================================
# This script trains a simple machine learning model to predict investment risk ratings
# based on historical performance metrics and asset characteristics.

library(tidyverse)
library(tidymodels)
library(lubridate)

# Check if synthetic data exists
if (!file.exists("data/synthetic-portfolio-holdings.csv")) {
  cat("Synthetic data not found. Generating data...\n")
  source("data/generate_data.R")
}

set.seed(123)

cat("Loading data...\n")
# Load data
holdings <- read_csv("data/synthetic-portfolio-holdings.csv", show_col_types = FALSE)
performance <- read_csv("data/synthetic-performance-history.csv", show_col_types = FALSE)

# Prepare features for modeling
cat("Preparing features...\n")

# Calculate performance metrics for each investment
performance_metrics <- performance |>
  filter(!is.na(monthly_return)) |>
  group_by(investment_id) |>
  summarise(
    avg_return = mean(monthly_return, na.rm = TRUE),
    volatility = sd(monthly_return, na.rm = TRUE),
    max_drawdown = min(monthly_return, na.rm = TRUE),
    positive_months = sum(monthly_return > 0, na.rm = TRUE) / n(),
    return_consistency = 1 / (1 + sd(monthly_return, na.rm = TRUE)),
    n_periods = n(),
    .groups = "drop"
  )

# Join with holdings data
model_data <- holdings |>
  inner_join(performance_metrics, by = "investment_id") |>
  filter(!is.na(risk_rating)) |>
  mutate(
    # Convert risk rating to ordered factor
    risk_rating = factor(risk_rating,
                        levels = c("Low", "Medium-Low", "Medium", "Medium-High", "High"),
                        ordered = TRUE),
    # Calculate days held
    days_held = as.numeric(today() - acquisition_date),
    # Current yield (handle NAs)
    current_yield = replace_na(current_yield, 0),
    # Asset class as factor
    asset_class = factor(asset_class)
  ) |>
  select(
    risk_rating,
    asset_class,
    volatility,
    avg_return,
    max_drawdown,
    positive_months,
    return_consistency,
    days_held,
    current_yield,
    market_value
  )

cat("Model data prepared:", nrow(model_data), "observations\n")

# Split data
cat("Splitting data into train/test sets...\n")
data_split <- initial_split(model_data, prop = 0.75, strata = risk_rating)
train_data <- training(data_split)
test_data <- testing(data_split)

cat("  Training set:", nrow(train_data), "observations\n")
cat("  Test set:", nrow(test_data), "observations\n")

# Define recipe
cat("Defining preprocessing recipe...\n")
risk_recipe <- recipe(risk_rating ~ ., data = train_data) |>
  step_normalize(all_numeric_predictors()) |>
  step_dummy(all_nominal_predictors())

# Define model - using random forest for multi-class classification
cat("Defining random forest model...\n")
rf_spec <- rand_forest(trees = 100, min_n = 5) |>
  set_engine("ranger", importance = "impurity") |>
  set_mode("classification")

# Create workflow
cat("Creating modeling workflow...\n")
risk_workflow <- workflow() |>
  add_recipe(risk_recipe) |>
  add_model(rf_spec)

# Train model
cat("Training model...\n")
risk_fit <- risk_workflow |>
  fit(data = train_data)

cat("Model training complete!\n")

# Evaluate model
cat("\nEvaluating model performance...\n")

# Predictions on test set
test_predictions <- predict(risk_fit, test_data) |>
  bind_cols(predict(risk_fit, test_data, type = "prob")) |>
  bind_cols(test_data |> select(risk_rating))

# Calculate metrics
test_metrics <- test_predictions |>
  metrics(truth = risk_rating, estimate = .pred_class)

cat("\nTest Set Performance:\n")
print(test_metrics, n = Inf)

# Confusion matrix
conf_mat <- test_predictions |>
  conf_mat(truth = risk_rating, estimate = .pred_class)

cat("\nConfusion Matrix:\n")
print(conf_mat)

# Feature importance
cat("\nExtracting feature importance...\n")
importance_data <- risk_fit |>
  extract_fit_parsnip() |>
  vip::vi() |>
  mutate(
    Variable = str_remove(Variable, "asset_class_"),
    Variable = str_replace_all(Variable, "_", " "),
    Variable = str_to_title(Variable)
  ) |>
  slice_max(Importance, n = 10)

cat("\nTop 10 Most Important Features:\n")
print(importance_data, n = 10)

# Save model
cat("\nSaving model artifacts...\n")
saveRDS(risk_fit, "ml/risk_prediction_model.rds")
saveRDS(importance_data, "ml/feature_importance.rds")
saveRDS(test_metrics, "ml/model_metrics.rds")

# Create a vetiver model for deployment
cat("Creating vetiver model for deployment...\n")
library(vetiver)

v <- vetiver_model(
  risk_fit,
  model_name = "portfolio_risk_predictor",
  description = "Random forest model to predict investment risk ratings based on performance metrics"
)

# Save vetiver model
vetiver_pin_write(board = pins::board_folder("ml/"), v)

cat("\nModel artifacts saved successfully!\n")
cat("  - ml/risk_prediction_model.rds\n")
cat("  - ml/feature_importance.rds\n")
cat("  - ml/model_metrics.rds\n")
cat("  - ml/pins-board/ (vetiver deployment)\n")

# Print summary
cat("\n=== Model Summary ===\n")
cat("Model Type: Random Forest Classifier\n")
cat("Target Variable: Investment Risk Rating (5 classes)\n")
cat("Training Observations:", nrow(train_data), "\n")
cat("Test Observations:", nrow(test_data), "\n")
cat("Test Accuracy:", round(test_metrics |> filter(.metric == "accuracy") |> pull(.estimate), 3), "\n")
cat("\nModel is ready for deployment via API!\n")
