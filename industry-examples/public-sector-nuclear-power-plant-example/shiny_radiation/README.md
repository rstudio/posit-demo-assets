# Shiny Dashboard with Random Data

- Interactive Shiny application in French
- Real-time radiation level monitoring
- Spatial sensor network map
- Public-friendly data presentation

## Usage

Setup the `renv` environment:

```r
renv::activate()
renv::restore()
```

To run the app either open `shiny_radiation/app.R` and click the "Run App" button at the top of the IDE code pane or use:

```r
shiny::runApp("app")
```

## Deployment

### Push Button

Open `shiny_radiation/app.R` and use the blue publish icon in the upper right corner of the IDE code pane.

### rsconnect package

You can also deploy using the rsconnect package:

```
rsconnect::deployApp(
  appDir = "app",
  appTitle = "Public Radiation Monitoring Dashboard"
)
```

### Git-backed

Update the code, and then run:

```r
rsconnect::writeManifest("app")
```

Commit the new `manifest.json` file to the git repo along with the code.

## Resources

[Posit Connect User Guide: Shiny](https://docs.posit.co/connect/user/shiny/)
