# plumber.R
library(tidyverse)
library(tidymodels)
library(finetune)
library(xgboost)
library(arrow)
library(plumber)
library(bundle)

#* @apiTitle Loan Risk Classification API
#* @apiDescription Classifies a loan as A, B, C, or D depending on the risk
#*     profile of the applicant. A is the least risky and D is the most risky.

#* Predict a loan status
#* @param age:int Age of loan holder
#* @param district_id:int District ID of loan holder
#* @param amount:numeric Amount of loan in USD
#* @param duration:int Duration of loan in months
#* @param fico:int FICO score of loan applicant
#* @post /predict
function(age=47L, district_id=63L, amount=5000, duration=12L, fico=750){
  
  mod_bundle <- readRDS("model/xgb_final_fit.rds")
  xgb_final_fit <- unbundle(mod_bundle)

  predict_df <- tibble(
    age = as.integer(age),
    district_id = as.integer(district_id),
    amount = as.numeric(amount),
    duration = as.integer(duration),
    fico = as.integer(fico)
  )
 
  risk_category <- predict(xgb_final_fit, predict_df) |>
    pull(.pred_class) |>
    as.character()
}

#* List District Information
#* @param city:string City name
#* @param state_abbrev:string State abbreviation
#* @param region:string Region name
#* @param division:string Division name
#* @get /districts
function(city="", state_abbrev="", region="", division="") {
  district_df <- read_parquet("district.parquet") |>
    mutate(district_id = as.integer(district_id))

  if (city != "") {
    district_df <- filter(district_df, city == !!city)
  }
  if (state_abbrev != "") {
    district_df <- filter(district_df, state_abbrev == !!state_abbrev)
  }
  if (region != "") {
    district_df <- filter(district_df, region == !!region)
  }
  if (division != "") {
    district_df <- filter(district_df, division == !!division)
  }
  return(district_df)
}