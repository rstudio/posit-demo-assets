library(tidyverse)
library(tidymodels)
library(finetune)
library(xgboost)
library(arrow)
library(bundle)


# Data Load
disp_df <- read_parquet("data/disposition.parquet")
client_df <- read_parquet("data/client.parquet")
loans_df <- read_parquet("data/loan.parquet")

all_data <- loans_df |>
  left_join(filter(disp_df, type == "Owner"), by = "account_id") |>
  left_join(rename(client_df, dob = fulldate), by = "client_id") |>
  filter(as.numeric(stringr::str_replace_all(loan_id, "L", "")) < 7308) |>
  rowwise() |>
  mutate(fico = round(case_when(
    status == "A" ~ rnorm(1, mean=790, sd=75),
    status == "B" ~ rnorm(1, mean=760, sd=75),
    status == "C" ~ rnorm(1, mean=675, sd=75),
    status == "D" ~ rnorm(1, mean=540, sd=75),
  )))


model_data <- all_data |>
  select(client_id, age, district_id, status, amount, duration, fico) |>
  mutate(status = factor(status, levels = c("A", "B", "C", "D"))) %>%
  mutate(age = as.integer(age),
         district_id = as.integer(district_id),
         amount = as.numeric(amount),
         duration = as.integer(duration),
         fico = as.integer(fico))

xgb_final_spec <-
  boost_tree(
    trees = 986,
    mtry = 2,
    min_n = 23,
    learn_rate = 0.00117
  ) |>
  set_engine("xgboost") |>
  set_mode("classification")

xgb_final_fit <- xgb_final_spec %>% fit(status ~ ., data = select(model_data, -client_id))

mod_bundle <- bundle(xgb_final_fit)
saveRDS(mod_bundle, file = "model/xgb_final_fit.rds")