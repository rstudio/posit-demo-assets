# Plumber API with Penguins Data

A demo of how to use [Plumber](https://www.rplumber.io/index.html) to create APIs on Posit Connect.

![screenshot](imgs/screenshot.png)

## Usage

Setup the `renv` environment:

```r
renv::activate()
renv::restore()
```

To run the API locally:

Open the `plumber.R` file in the IDE and click the "Run API" button.

## Deployment

### Push Button

Use the blue publish icon in the upper right corner of the IDE code pane.

### rsconnect package

You can also deploy using the rsconnect package:

```
rsconnect::deployAPI(
  api = "app",
  appFiles = c("plumber.R"),
  appTitle = "Shiny Penguins Plumber"
)
```

### Git-backed

Update the code, and then run:

```r
rsconnect::writeManifest("app")
```

Commit the new `manifest.json` file to the git repo along with the code.


## Resources

[Posit Connect User Guide: Plumber](https://docs.posit.co/connect/user/plumber/)