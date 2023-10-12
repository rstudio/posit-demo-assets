# demo-rmd-penguins

An parameterized RMarkdown report!

- Code: <https://github.com/SamEdwardes/demo-rmd-penguins>
- Deployment: <https://colorado.rstudio.com/rsc/demo-rmd-penguins/>

![](report/imgs/report-screenshot.png)

## Usage

To render the report run:

```r
knit_with_parameters("~/projects/demo-rmd-penguins/report.Rmd")
```

## Deployment

### Git-backed

To deploy the report to RStudio Connect:

```r
rsconnect::writeManifest("report")
```

Then commit any changes to GitHub.

### Programatic

You can also deploy using the `rsconnect` api:

```r
rsconnect::deployDoc(
  doc = "report/report.Rmd",
  appTitle = "RMarkdown Penguins API Deployment"
)
```
