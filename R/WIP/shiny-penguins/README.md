# demo-shiny-penguins

Palmer's penguins shiny dashboard demo.

- Code: <https://github.com/SamEdwardes/demo-shiny-penguins>
- Deployment: <https://colorado.rstudio.com/rsc/demo-shiny-penguins/>

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

The app will be automatically redeployed by RStudio Connect.

### Programatic

You can also deploy the app using the `rsconnect` api:

```r
rsconnect::deployApp(
  appDir = ".",
  appFiles = c("app.R"),
  appTitle = "Shiny Penguins API Deployment"
)
```