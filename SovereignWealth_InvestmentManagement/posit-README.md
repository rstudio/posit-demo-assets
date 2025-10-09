# SovereignWealth Capital Demo - Internal Guide for Posit Team

## Quick Overview

**Customer**: Chickasaw Nation (Current Customer)
**Departments**: Investment Management & Financial Planning Analysis
**Industry**: Tribal Investment Management
**Use Case**: Portfolio performance dashboard with AI/LLM capabilities in Positron

**Demo Time**: 10-15 minutes
**Fictional Company**: SovereignWealth Capital
**Portfolio Size**: $366M across 79 holdings

## What This Demo Shows

This demonstration highlights:
1. **Positron IDE** with AI/LLM capabilities for data science workflows
2. **Interactive dashboards** for portfolio monitoring
3. **Machine learning** for investment risk prediction
4. **REST APIs** for programmatic data access
5. **Comprehensive analytics** with missing data handling

## Data Context

All data is **synthetic and AI-generated** to demonstrate capabilities:

- **79 holdings** across 7 asset classes (Equities, Fixed Income, Real Estate, Private Equity, Infrastructure, Natural Resources, Cash)
- **5 years** of monthly performance data
- **Realistic missing data** patterns (15% cost basis, 5% recent performance)
- **340 transactions** spanning 2015-2024

The data mimics a diversified tribal investment portfolio managing community assets for long-term sustainability.

## Pre-Demo Setup

### 1. Environment Check
```r
# Verify renv is working
renv::status()

# If needed, restore
renv::restore()
```

### 2. Generate Data
```r
# Only if data doesn't exist
source("data/generate_data.R")
```

### 3. Verify ML Model
```r
# Check model exists
file.exists("ml/risk_prediction_model.rds")

# If FALSE, train it
source("ml/train_model.R")
```

### 4. Test Components
```r
# Test Shiny app (Ctrl+C to stop)
shiny::runApp("app.R")

# Test API (Ctrl+C to stop)
plumber::plumb("api.R")$run(port = 8000)

# Render analysis
quarto::quarto_render("eda.qmd")
```

## Demo Script

### Introduction (1 min)
"This is a portfolio management demonstration for tribal investment operations, similar to Chickasaw Nation's investment management needs. We're looking at a fictional $366M portfolio managed by SovereignWealth Capital."

### Part 1: Interactive Dashboard (4 min)

```r
shiny::runApp("app.R")
```

**Key talking points:**
- **Overview Tab**: Show $366M portfolio value, 79 holdings, 7 asset classes, 10.7% YTD return
- **Allocation**: Point out diversification across asset classes
- **Performance Tab**: Highlight 5-year cumulative returns and rolling 12-month performance
- **Risk Analysis**: Show risk distribution and volatility metrics
- **Data Quality**: Demonstrate realistic missing data handling (15% cost basis missing)

**Emphasize:**
- "Built with Shiny and bslib for professional branding using `_brand.yml`"
- "All data updates reactively as filters change"
- "Handles missing data appropriately - common in legacy portfolio transfers"

### Part 2: Analytics Report (3 min)

```r
# Open eda.html in browser
browseURL("eda.html")
```

**Key talking points:**
- "Comprehensive analysis created with Quarto"
- Navigate to: Executive Summary → Portfolio Composition → Performance Analysis
- "Notice the missing data assessment - we explicitly handle incomplete records"
- "Risk-adjusted returns show Private Equity performing well"

### Part 3: Machine Learning (3 min)

```r
# Show model training
source("ml/train_model.R")
```

**Key talking points:**
- "Simple random forest model predicts investment risk ratings"
- "Uses performance metrics: volatility, returns, drawdown, consistency"
- "Market value and days held are key features"
- "Ready for deployment via vetiver"

### Part 4: REST API (2 min)

```r
api <- plumber::plumb("api.R")
api$run(port = 8000)

# Open Swagger docs
browseURL("http://localhost:8000/__docs__/")
```

**Key endpoints to demo:**
- `GET /portfolio/summary` - Quick overview
- `GET /portfolio/holdings` - All investments
- `POST /predict/risk` - ML predictions
- `GET /model-info` - Model details

**Emphasize:**
- "Plumber creates production-ready APIs"
- "Automatic OpenAPI/Swagger documentation"
- "Can integrate with external systems"

### Part 5: Positron Features (2 min)

**Highlight (if demoing in Positron):**
- AI-assisted code completion
- Interactive variable explorer
- Integrated data viewer
- Plot pane for visualizations
- Terminal for command execution

## Key Insights to Highlight

1. **Diversification**: 7 asset classes with no single class >25%
2. **Performance**: 7.8% annualized return over 5 years
3. **Risk Management**: 70% of holdings in Low-Medium risk
4. **Data Quality**: Proper handling of 15% missing cost basis
5. **Real-time Monitoring**: Dashboard updates immediately

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Data files missing | Run `source("data/generate_data.R")` |
| Model not found | Run `source("ml/train_model.R")` |
| Package errors | Run `renv::restore()` |
| Port already in use | Change port number in runApp() |
| Quarto not rendering | Install Quarto: https://quarto.org/docs/get-started/ |

## Technical Details

- **Language**: R 4.5+
- **Key Packages**: tidyverse, shiny, bslib, tidymodels, plumber, quarto
- **Environment**: renv for reproducibility
- **Data**: 100% synthetic, AI-generated
- **Model**: Random forest, 38% test accuracy (small dataset)

## Customization Notes

For future demos:
- Edit `data/generate_data.R` to adjust portfolio size/composition
- Modify `_brand.yml` for different branding
- Update asset classes in holdings generation
- Adjust time periods for performance data

## Next Steps & Call to Action

After the demo:
1. "How does this align with your current portfolio monitoring process?"
2. "What additional metrics would be valuable for your team?"
3. "Would API access to portfolio data streamline your workflows?"
4. "Let's discuss integrating this with your actual data sources"

## Important Notes

- **All data is synthetic** - emphasize this clearly
- **No real Chickasaw Nation data** was used
- **Model accuracy is intentionally limited** due to small dataset
- This is a **technical demonstration** of capabilities
- Focus on **workflow and tooling**, not specific predictions

## Success Metrics

A successful demo:
- Demonstrates Positron IDE capabilities
- Shows complete data science workflow
- Illustrates realistic business scenario
- Generates discussion about their actual needs
- Leads to next steps conversation

## Contact

For questions or customization requests, contact your Posit Solutions Engineering team.

---

*Last Updated: 2025-10-09*
*Demo Version: 1.0*
*Fictional Company: SovereignWealth Capital*
