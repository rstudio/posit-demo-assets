# Using pins with Penguins Data

A demo of using pins with Posit Pro Products.

## Environment variable requirements

This content needs to have the following environment variables set to function:
- `CONNECT_SERVER` the URL of your Connect server, for Test Drive it will be in this format: https://YOUR_DOMAIN_HERE.eval.posit.co/cnct
- `CONNECT_API_KEY` an API key from your Connect server. See [API Keys](https://docs.posit.co/connect/user/api-keys/) in the Connect User guide for more information.
 
Variables can be saved in an .Renviron config file when working with this project. [`usethis`](https://usethis.r-lib.org/) has a function for creating and editing .Renviron files: 

Add the variables to that file in the format `KEY=VALUE` and save it. Restart the session so the new environment variables will be loaded with `ctrl shift f10` or through the RStudio IDE through the **Session** dropdown and selecting **Restart R**.

## Usage

Setup the `renv` environment:

```r
renv::activate()
renv::restore()
```

To render the dashboard either open `report/pins-r-penguins.Rmd` and use the "Knit" button on the top of the IDE code pane and select "Knit to HTML" or use:

```r
rmarkdown::render("report/pins-r-penguins.Rmd")
```

## Deployment

### Push Button

Open `report/pins-r-penguins.Rmd` and use the blue publish icon in the upper right corner of the IDE code pane.

### rsconnect package

You can also deploy using the rsconnect package:

```
rsconnect::deployDoc(
  doc = "report/pins-r-penguins.Rmd",
  appTitle = "R Pins Example"
)
```

### Git-backed

Update the code, and then run:

```r
rsconnect::writeManifest(
  "report", 
  appFiles = c("pins-r-penguins.Rmd")
)
```

Commit the new `manifest.json` file to the git repo along with the code.

## Resources

[Posit Connect How-to Guide: Pins](https://docs.posit.co/connect/how-to/pins/)
