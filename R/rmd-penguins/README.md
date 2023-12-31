# R Markdown Report with Penguins Data

A parameterized RMarkdown report!

![screenshot of the R Markdown report](report-screenshot.png)

## Usage

Setup the `renv` environment:

```r
renv::activate()
renv::restore()
```

To render the dashboard either open `report/rmd-penguins.Rmd` and use the "Knit" button on the top of the IDE code pane and select "Knit to HTML" or use:

```r
rmarkdown::render("report/rmd-penguins.Rmd")
```

## Deployment

### Push Button

Open `report/rmd-penguins.Rmd` and use the blue publish icon in the upper right corner of the IDE code pane.

### rsconnect package

You can also deploy using the rsconnect package:

```
rsconnect::deployDoc(
  doc = "report/rmd-penguins.Rmd",
  appTitle = "R Markdown Penguins"
)
```

### Git-backed

Update the code, and then run:

```r
rsconnect::writeManifest(appDir = "report")
```

Commit the new `manifest.json` file to the git repo along with the code.

## Resources

[Posit Connect User Guide: R Markdown](https://docs.posit.co/connect/user/rmarkdown/)

