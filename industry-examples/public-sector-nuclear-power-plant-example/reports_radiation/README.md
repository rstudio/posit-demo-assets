# Technical Report as an R Markdown with Random Data

- Comprehensive R Markdown report for internal use
- Statistical analysis and visualizations
- Anomaly detection results
- Regulatory compliance assessment


## Usage

Setup the `renv` environment:

```r
renv::activate()
renv::restore()
```

To render the dashboard either open `reports_radiation/technical_report.Rmd` and use the "Knit" button on the top of the IDE code pane and select "Knit to HTML" or use:

```r
rmarkdown::render("reports_radiation/technical_report.Rmd")
```

## Deployment

### Push Button

Open `reports_radiation/technical_report.Rmd` and use the blue publish icon in the upper right corner of the IDE code pane.

### rsconnect package

You can also deploy using the rsconnect package:

```
rsconnect::deployDoc(
  doc = "reports_radiation/technical_report.Rmd",
  appTitle = "Environmental Radiation Monitoring R Markdown Report"
)
```

### Git-backed

Update the code, and then run:

```r
rsconnect::writeManifest(appDir = "reports_radiation")
```

Commit the new `manifest.json` file to the git repo along with the code.

## Resources

[Posit Connect User Guide: R Markdown](https://docs.posit.co/connect/user/rmarkdown/)

