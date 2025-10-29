# -*- coding: utf-8 -*-
import os
from datetime import date
from typing import List

import xgboost as xgb
import numpy as np
import pandas as pd
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel, Field
from enum import Enum


def validate_district(district_id):
    if district_id not in range(1,77):
        raise HTTPException(status_code=404, detail="Incorrect District ID. Must be between 1 and 77.")

def convert_risk(status):
    if status == 0:
        return RiskCategory("A")
    elif status == 1:
        return RiskCategory("B")
    elif status == 2:
        return RiskCategory("C")
    else:
        return RiskCategory("D")

class RiskCategory(str, Enum):
    A = 'A'
    B = 'B'
    C = 'C'
    D = 'D'

class Prediction(BaseModel):
    risk: list[RiskCategory]

class District(BaseModel):
    district_id: float
    city: str
    state_name: str
    state_abbrev: str
    region: str
    division: str

app = FastAPI(
    title="Loan Risk API",
    description="The Loan Risk API provides a prediction endpoint for determining the risk classification of a loan applicant.",
)


@app.post("/predict")
async def predict(age: int = 47, district_id: int = 63, amount: float = 5000, duration: int = 12, fico: int = 750) -> RiskCategory:
    # Load model
    xgb_model = xgb.XGBClassifier()
    xgb_model.load_model("model/xgb_final_model.json")
    
    # Create a dataframe from inputs 
    data = pd.DataFrame([[age,district_id,amount,duration, fico]], columns=["age", "district_id", "amount", "duration", "fico"])
    print(data)
    # Make the prediction
    y_pred = xgb_model.predict(data)
    
    return convert_risk(y_pred)

@app.get("/districts")
async def districts(city: str | None = None, state_abbrev: str | None = None, region: str | None = None, division: str | None = None) -> list[District]:
    district_df = pd.read_parquet("data/district.parquet", engine='fastparquet')

    if city is not None:
        district_df = district_df[(district_df['city'] == city)]

    if state_abbrev is not None:
        district_df = district_df[(district_df['state_abbrev'] == state_abbrev)]

    if region is not None:
        district_df = district_df[(district_df['region'] == region)]

    if division is not None:
        district_df = district_df[(district_df['division'] == division)]

    return_list =[] 
    
    # Iterate over each row 
    for index, rows in district_df.iterrows(): 
        my_list = District(district_id=rows.district_id, city=rows.city, state_name=rows.state_name, state_abbrev=rows.state_abbrev, region=rows.region, division=rows.division)
        return_list.append(my_list) 

    return return_list