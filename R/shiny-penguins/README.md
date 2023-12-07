# Shiny Dashboard with Penguins Data

Palmer's penguins shiny dashboard demo.

![screenshot](./imgs/app-screenshot.png)

## Usage

```r
shiny::runApp('app')
```

## Deployment

### Git-backed

Update the code, and then run:

```r
rsconnect::writeManifest()
```

The app will be automatically redeployed by Posit Connect.

### Programatic

You can also deploy the app using the `rsconnect` api:

```r
rsconnect::deployApp(
  appDir = ".",
  appFiles = c("app.R"),
  appTitle = "Shiny Penguins API Deployment"
)
```
