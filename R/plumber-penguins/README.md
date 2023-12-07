# Plumber API with Penguins Data

A demo of how to use [Plumber](https://www.rplumber.io/index.html) to create APIs on Posit Connect.

![screenshot](imgs/screenshot.png)

## Usage

```bash
curl -X GET "https://${CONNECT_SERVER}/r/plumber-penguins/penguins?sample_size=5"
```

## Deployment

### Git-backed

After making any code changes run the following:

```r
rsconnect::writeManifest("app")
```

Posit Connect will then automatically redeploy the app.

### Programatic

You can also deploy the app using the `rsconnect` api:

```r
rsconnect::deployAPI(
  api = "app",
  appFiles = c("plumber.R"),
  appTitle = "Shiny Penguins Plumber"
)
```
