# Model Utility Functions
# =======================
# Helper functions for loading and using the risk prediction model

library(tidymodels)
library(vetiver)

#' Load the trained risk prediction model
#'
#' @return A fitted workflow object
load_risk_model <- function() {
  model_path <- "ml/risk_prediction_model.rds"
  if (!file.exists(model_path)) {
    stop("Model file not found. Please run ml/train_model.R first.")
  }
  readRDS(model_path)
}

#' Load vetiver model from pin board
#'
#' @return A vetiver model object
load_vetiver_model <- function() {
  board <- pins::board_folder("ml/")
  vetiver_pin_read(board, "portfolio_risk_predictor")
}

#' Predict risk rating for new investment data
#'
#' @param model Trained model object
#' @param new_data A data frame with required features
#' @return Data frame with predictions and probabilities
predict_risk <- function(model, new_data) {
  predictions <- predict(model, new_data) |>
    bind_cols(predict(model, new_data, type = "prob")) |>
    bind_cols(new_data)

  predictions
}

#' Get feature importance
#'
#' @return Data frame with feature importance scores
get_feature_importance <- function() {
  importance_path <- "ml/feature_importance.rds"
  if (!file.exists(importance_path)) {
    stop("Feature importance file not found. Please run ml/train_model.R first.")
  }
  readRDS(importance_path)
}

#' Get model performance metrics
#'
#' @return Data frame with model metrics
get_model_metrics <- function() {
  metrics_path <- "ml/model_metrics.rds"
  if (!file.exists(metrics_path)) {
    stop("Model metrics file not found. Please run ml/train_model.R first.")
  }
  readRDS(metrics_path)
}
