# R Markdown Blastula Email Sending

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

To render the report locally open `report/connect-content-report.Rmd` and use the "Knit" button on the top of the IDE code pane and select "Knit to HTML".

To render an email preview locally use:

```r
rmarkdown::render("report/connect-content-report.Rmd")
```

## Deployment

### Push Button

Open `report/connect-content-report.Rmd` and use the blue publish icon in the upper right corner of the IDE code pane. Ensure you select "Publish document with source code" and include `connect-content-report.Rmd` and `connect-content-email.Rmd` documents.

### Git-backed

Update the code, and then run:

```r
rsconnect::writeManifest(
  appDir = "report", 
  appPrimaryDoc = "connect-content-report.Rmd",
  appFiles = c("connect-content-email.Rmd")
)
```

Commit the new `manifest.json` file to the git repo along with the code.

## Resources

[Posit Connect User Guide: Email Customization](https://docs.posit.co/connect/user/rmarkdown/index.html#r-markdown-email-customization)
[Posit Solutions: Custom Emails with R Markdown and Blastula](https://solutions.posit.co/write-code/blastula/index.html)


