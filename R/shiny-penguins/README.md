# Shiny Dashboard with Penguins Data

Palmer's penguins shiny dashboard demo.

![screenshot](app-screenshot.png)

## Usage

Setup the `renv` environment:

```r
renv::activate()
renv::restore()
```

To run the app either open `app/app.R` and click the "Run App" button at the top of the IDE code pane or use:

```r
shiny::runApp("app")
```

## Deployment

### Push Button

Open `app/app.R` and use the blue publish icon in the upper right corner of the IDE code pane.

### rsconnect package

You can also deploy using the rsconnect package:

```
rsconnect::deployApp(
  appDir = "app",
  appTitle = "Shiny Penguins"
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
