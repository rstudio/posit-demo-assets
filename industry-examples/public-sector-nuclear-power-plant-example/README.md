# Radiation Monitoring Demo

This project demonstrates how to ( ) use Posit tools for environmental radiation monitoring around nuclear facilities.

## Demo Scenario

An   R programmer analyzes environmental radiation sensor data from the Flamanville nuclear facility to:
- Detect anomalies in radiation levels
- Assess regulatory compliance
- Generate technical reports for experts
- Create public dashboards for transparency

## Project Structure

```
 _Radiation_Demo/
├── data/                           # Sample sensor and weather data
│   ├── flamanville_sensors_2024.csv
│   ├── meteorological_2024.csv
│   ├── sensor_locations.csv
│   └── regulatory_thresholds.csv
├── R/                              # Analysis scripts and functions
│   ├── generate_sample_data.R
│   └── radiation_analysis.R
├── reports/                        # R Markdown technical reports
│   └── technical_report.Rmd
├── shiny_app/                      # Public-facing dashboard
│   └── app.R
├── docs/                           # Documentation
├──  _Radiation_Demo.Rproj      # R Project file
├── renv.lock                       # Package dependencies
└── README.md
```

## Key Features

### 1. Data Generation (`R/generate_sample_data.R`)
- Creates realistic radiation sensor data with natural variations
- Simulates weather correlation effects
- Includes anomaly periods for demonstration

### 2. Analysis Functions (`R/radiation_analysis.R`)
- Statistical process control for anomaly detection
- Regulatory compliance assessment
- Weather correlation analysis
- Spatial mapping capabilities

### 3. Technical Report (`reports_radiation/technical_report.Rmd`)
- Comprehensive R Markdown report for internal use
- Statistical analysis and visualizations
- Anomaly detection results
- Regulatory compliance assessment

### 4. Public Dashboard (`shiny_radiation/app.R`)
- Interactive Shiny application in French
- Real-time radiation level monitoring
- Spatial sensor network map
- Public-friendly data presentation

## Posit Products Demonstrated

- **Posit Workbench**: Secure R development environment
- **Posit Connect**: Automated report scheduling and app deployment
- **Posit Package Manager**: Consistent, validated package management

## Getting Started

### Prerequisites
- R 4.3.0 or higher
- RStudio (or Posit Workbench)
- Required packages (managed via renv)

### Installation
1. Clone or download this project
2. Open ` _Radiation_Demo.Rproj` in RStudio
3. Install dependencies:
   ```r
   renv::restore()
   ```

### Generate Sample Data
```r
source("R/generate_sample_data.R")
```

### Run Analysis
```r
source("R/radiation_analysis.R")
data_list <- load_radiation_data()
```

### Generate Technical Report
```r
rmarkdown::render("reports_radiation/technical_report.Rmd")
```

### Launch Public Dashboard
```r
shiny::runApp("shiny_radiation")
```

## Demo Narrative Points

### 1. Secure Workspace (Posit Workbench)
- Project organization with version control
- Validated package management
- Collaborative development environment

### 2. Data Analysis Workflow
- Real-time data ingestion from multiple sensors
- Statistical anomaly detection algorithms
- Automated quality control processes

### 3. Dual-Purpose Reporting
- **Technical Report**: Detailed analysis for experts
- **Public Dashboard**: Accessible information for citizens

### 4. Deployment (Posit Connect)
- One-click publishing from development to production
- Automated report scheduling
- Secure access controls

## Key Value Propositions

- **Reproducibility**: All analyses fully documented and version-controlled
- **Transparency**: Public access to environmental monitoring data
- **Efficiency**: Automated workflows reduce manual effort
- **Compliance**: Built-in regulatory threshold monitoring
- **Collaboration**: Team-based development and review processes

## Sample Output

The demo generates:
- 10,815 radiation measurements from 15 sensors over 30 days
- Interactive maps showing sensor locations and current readings
- Time series plots with regulatory threshold overlays
- Weather correlation analysis
- Automated anomaly detection reports

## Regulatory Context

This demo showcases how government agencies can use Posit tools to:
- Maintain scientific rigor in public safety monitoring
- Provide transparent communication to citizens
- Ensure regulatory compliance and auditability
- Scale data science capabilities across the organization

## Contact

For questions about this demo or Posit implementation in government agencies, contact your Posit sales representative.
