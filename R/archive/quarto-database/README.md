# Working with Databases in RStudio

![screenshot of Quarto doc](quarto-database.png)

## Usage

Setup the `renv` environment:

```r
renv::activate()
renv::restore()
```

To render the document either open `report/quarto-database.qmd` and use the "Render" button on the top of the IDE code pane or use:

```r
quarto::quarto_render("report/quarto-database.qmd")
```

## Deployment

### Push Button

Open `report/quarto-database.qmd` and use the blue publish icon in the upper right corner of the IDE code pane.

### rsconnect package

You can also deploy using the rsconnect package:

```
rsconnect::deployDoc(
  doc = "report/quarto-database.qmd",
  appTitle = "Quarto Database Example"
)
```

### Git-backed

Update the code, and then run:

```r
rsconnect::writeManifest("report")
```

Commit the new `manifest.json` file to the git repo along with the code.

## Resources

- [Posit Connect User Guide: Quarto](https://docs.posit.co/connect/user/quarto/)
- [quarto cli](https://quarto.org/docs/publishing/rstudio-connect.html)
- [quarto projects](https://quarto.org/docs/projects/quarto-projects.html)
- [Posit Connect User Guide - Git Backed Publishing ](https://docs.posit.co/connect/user/git-backed/)
