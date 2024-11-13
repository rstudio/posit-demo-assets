# R Markdown Based Flexdashboard with Sales Data

A demo of a parameterized sales dashboard build using flexdashboard in an R Markdown file.

![screenshot of the R Markdown Flexdashboard](sales-dashboard-screenshot.png)

## Usage

Setup the `renv` environment:

```r
renv::activate()
renv::restore()
```

To render the dashboard open `dashboard/sales-dashboard.Rmd` and use the "Knit" button on the top of the IDE code pane and select "Knit with Parameters".

## Deployment

### Push Button

Open `dashboard/sales-dashboard.Rmd` and use the blue publish icon in the upper right corner of the IDE code pane.

### rsconnect package

You can also deploy using the rsconnect package:

```
rsconnect::deployDoc(
  doc = "dashboard/sales-dashboard.Rmd",
  appTitle = "R Markdown Sales Flexdashboard"
)
```

### Git-backed

Update the code, and then run:

```r
rsconnect::writeManifest("dashboard")
```

Commit the new `manifest.json` file to the git repo along with the code.

## Resources

[Posit Connect User Guide: R Markdown](https://docs.posit.co/connect/user/rmarkdown/)
[Posit Connect User Guide: Parameterized R Markdown](https://docs.posit.co/connect/user/param-rmarkdown/)

