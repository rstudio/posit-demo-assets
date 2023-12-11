# R Markdown Based Flexdashboard with Sales Data

A demo of a parameterized sales dashboard build using flexdashboard in an R Markdown file.

![](img/sales-dashboard-screenshot.png)

## Usage

Setup the `renv` environment:

```r
renv::activate()
renv::restore()
```

To render the dashboard run:

```r
knit_with_parameters("sales-dashboard.Rmd")
```

## Deployment

### Push Button

Use the "Knit" button on the top of the IDE code pane and select "Knit with Parameters".

### rsconnect package

You can also deploy using the rsconnect package:

```
rsconnect::deployDoc(
  doc = "sales-dashboard.Rmd",
  appTitle = "R Markdown Sales Flexdashboard"
)
```

### Git-backed

Update the code, and then run:

```r
rsconnect::writeManifest()
```

Commit the new `manifest.json` file to the git repo along with the code.


## Resources

[Posit Connect User Guide: R Markdown](https://docs.posit.co/connect/user/rmarkdown/)
[Posit Connect User Guide: Parameterized R Markdown](https://docs.posit.co/connect/user/param-rmarkdown/)

