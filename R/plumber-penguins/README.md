# demo-plumber-penguins

A demo of how to use [Plumber](https://www.rplumber.io/index.html) to create APIs on RStudio Connect.

- Code: <https://github.com/SamEdwardes/demo-plumber-penguins>
- Deployment: <https://colorado.rstudio.com/rsc/demo-plumber-penguins/>

<https://colorado.rstudio.com/rsc/palmerspenguins/>

![screenshot](imgs/screenshot.png)

## Usage

```bash
curl -X GET "https://colorado.rstudio.com/rsc/palmerspenguins/penguins?sample_size=5"
```

## Deployment

### Git-backed

After making any code changes run the following:

```r
rsconnect::writeManifest("app")
```

RStudio Connect will then automatically redeploy the app.

### Programatic

You can also deploy the app using the `rsconnect` api:

```r
rsconnect::deployAPI(
  api = "app",
  appFiles = c("plumber.R"),
  appTitle = "Shiny Penguins Plumber"
)
```
