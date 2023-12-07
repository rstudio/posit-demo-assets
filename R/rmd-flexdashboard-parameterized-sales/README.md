# R Markdown Based Flexdashboard with Sales Data

A demo of a parameterized sales dashboard build using flexdashboard in an R Markdown file.

![](img/sales-dashboard-screenshot.png)

## Usage

To render the dashboard run:

```r
knit_with_parameters("sales-dashboard.Rmd")
```

## Deployment

### Git-backed

To deploy the report to RStudio Connect:

```r
rsconnect::writeManifest()
```

Then commit any changes to GitHub.

### Programatic

You can also deploy using the `rsconnect` api:

```r
rsconnect::deployDoc(
  doc = "sales-dashboard.Rmd",
  appTitle = "RMarkdown Flexdashboard"
)
```
