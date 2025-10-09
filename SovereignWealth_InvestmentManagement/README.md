# SovereignWealth Capital - Portfolio Performance Dashboard

A comprehensive R-based demonstration project showcasing investment portfolio management, analysis, and risk prediction capabilities using Posit's data science tools.

## Project Overview

This project demonstrates a complete data science workflow for tribal investment management, featuring:

- **Portfolio Analytics**: Interactive dashboard for monitoring $366M+ in diversified investments
- **Machine Learning**: Risk prediction model for investment classification
- **REST API**: Programmatic access to portfolio data and predictions
- **Comprehensive Analysis**: Exploratory data analysis with detailed insights

## Features

### 1. Interactive Shiny Dashboard (`app.R`)
- Real-time portfolio metrics and KPIs
- Asset allocation visualization
- Performance tracking and benchmarking
- Transaction history analysis
- Risk assessment tools
- Data quality monitoring

### 2. Machine Learning Model (`ml/`)
- Random forest classifier for risk prediction
- Model performance metrics and validation
- Feature importance analysis
- Vetiver integration for deployment

### 3. REST API (`api.R`)
- Portfolio data access endpoints
- Risk prediction service
- Transaction queries
- OpenAPI/Swagger documentation

### 4. Exploratory Data Analysis (`eda.qmd`)
- Comprehensive portfolio analysis
- Performance benchmarking
- Risk-return profiling
- Missing data handling

## Installation

### Prerequisites
- R (>= 4.0)
- RStudio (recommended)

### Setup

1. **Clone or download this project**

2. **Open the project in RStudio**
   - Navigate to the project directory
   - Open the `.Rproj` file (if available) or set working directory

3. **Restore R environment**
   ```r
   # Install renv if needed
   install.packages("renv")

   # Restore project dependencies
   renv::restore()
   ```

4. **Generate synthetic data**
   ```r
   source("data/generate_data.R")
   ```

5. **Train the ML model**
   ```r
   source("ml/train_model.R")
   ```

## Usage

### Run the Interactive Dashboard

```r
shiny::runApp("app.R")
```

The dashboard will open in your default browser with tabs for:
- Overview: Portfolio summary and allocation
- Performance: Historical returns and analytics
- Transactions: Transaction history and volume
- Risk Analysis: Risk distribution and metrics
- Data Quality: Completeness assessment

### View the Analysis Report

```r
quarto::quarto_render("eda.qmd")
```

Opens an HTML report with comprehensive portfolio analysis.

### Start the API Server

```r
library(plumber)
api <- plumber::plumb("api.R")
api$run(port = 8000)
```

API documentation available at: `http://localhost:8000/__docs__/`

## Project Structure

```
SovereignWealth_InvestmentManagement/
├── data/
│   ├── generate_data.R              # Synthetic data generation
│   └── synthetic-*.csv              # Generated portfolio data
├── ml/
│   ├── train_model.R                # ML model training
│   ├── model_utils.R                # Model helper functions
│   └── *.rds                        # Saved model artifacts
├── app.R                             # Shiny dashboard
├── api.R                             # REST API
├── eda.qmd                           # Analysis report
├── _brand.yml                        # Brand/theme configuration
├── renv.lock                         # R dependencies
└── README.md                         # This file
```

## Data

The project uses **synthetic data** generated programmatically to demonstrate capabilities:

- **Holdings**: 79 investments across 7 asset classes
- **Performance**: 5 years of monthly return data
- **Transactions**: 340 historical transactions
- **Benchmarks**: Market index comparisons

Data includes realistic missing values (~5-15%) to demonstrate proper handling.

## Customization

### Branding

Modify `_brand.yml` to customize colors, typography, and theme:

```yaml
color:
  primary: "#006B7D"    # Main accent color
  secondary: "#4A5568"  # Secondary color

typography:
  base:
    family: Inter       # Body font
  headings:
    family: Merriweather  # Heading font
```

### Data Generation

Edit `data/generate_data.R` to:
- Adjust number of holdings
- Modify time periods
- Change asset allocation
- Customize missing data patterns

## API Endpoints

Key endpoints include:

- `GET /health` - Health check
- `GET /portfolio/summary` - Portfolio overview
- `GET /portfolio/holdings` - All holdings
- `GET /portfolio/allocation` - Asset allocation
- `GET /portfolio/performance` - Historical performance
- `POST /predict/risk` - Risk prediction
- `GET /model-info` - ML model details

## Machine Learning

The risk prediction model uses:
- Algorithm: Random Forest (100 trees)
- Target: 5-class risk rating (Low to High)
- Features: Volatility, returns, drawdown, consistency, etc.
- Validation: Train/test split with accuracy metrics

## Development

### Adding New Features

1. **New visualizations**: Add to `app.R` server function
2. **New endpoints**: Add to `api.R` with plumber decorators
3. **New analysis**: Extend `eda.qmd` with additional sections

### Regenerating Data

```r
source("data/generate_data.R")  # Creates fresh synthetic data
source("ml/train_model.R")       # Retrain model on new data
```

## Troubleshooting

### Missing Data Files
If data files don't exist, run:
```r
source("data/generate_data.R")
```

### Package Issues
Restore dependencies:
```r
renv::restore()
```

### Model Not Found
Train the model:
```r
source("ml/train_model.R")
```

## Support

For questions about adapting this demo to your needs, contact your Posit representative.

---

## Important Disclaimer

**This project contains synthetic data and analysis created for demonstration purposes only.**

All data, insights, business scenarios, and analytics presented in this demonstration project have been artificially generated using AI. The data does not represent actual business information, performance metrics, customer data, or operational statistics.

### Key Points:

- **Synthetic Data**: All datasets are computer-generated and designed to illustrate analytical capabilities
- **Illustrative Analysis**: Insights and recommendations are examples of the types of analysis possible with Posit tools
- **No Actual Business Data**: No real business information or data was used or accessed in creating this demonstration
- **Educational Purpose**: This project serves as a technical demonstration of data science workflows and reporting capabilities
- **AI-Generated Content**: Analysis, commentary, and business scenarios were created by AI for illustration purposes
- **No Real-World Implications**: The scenarios and insights presented should not be interpreted as actual business advice or strategies

This demonstration showcases how Posit's data science platform and open-source tools can be applied to the tribal investment management industry. The synthetic data and analysis provide a foundation for understanding the potential value of implementing similar analytical workflows with actual business data.

For questions about adapting these techniques to your real business scenarios, please contact your Posit representative.

---

*This demonstration was created using Posit's commercial data science tools and open-source packages. All synthetic data and analysis are provided for evaluation purposes only.*
