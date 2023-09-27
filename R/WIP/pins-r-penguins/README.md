# demo-pins-r-penguins

A demo of using pins with RStudio pro products.

- Data: <https://colorado.rstudio.com/rsc/demo-pins-penguins-data/>
- Report: <https://colorado.rstudio.com/rsc/demo-pins-r-penguins/>
- Code: <https://github.com/SamEdwardes/demo-pins-r-penguins>

![](app/imgs/connect-screenshot.png)

## Usage

Render the report in RStudio:

```r
rmarkdown::render("app/report.Rmd")
```

## Deployment

### Git-backed

Update the *manifest.json* file:

```r
rsconnect::writeManifest("app", appFiles = c("report.Rmd", "imgs"))
```

Then commit any changes to git. The report will automatically redeploy.

### Programatic

You can also deploy the app using the `rsconnect` api:

```r
rsconnect::deployDoc(
  doc = "app/report.Rmd",
  appTitle = "Pins Example"
)
```
