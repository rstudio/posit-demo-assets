# Scheduled Email Outputs with `blastula` to Monitor Air Quality

A demo of using a combination of `blastula`, `rmarkdown` and `pointblank` to create a schedulable report to continuously monitor air quality and email based on certain conditions.

-   Use `blastula` to create different customized emails that will
    replace the default email sent by Posit Connect
-   Use `blastula` to choose the email output depending on condition
-   Use `pointblank` to perform data validation from an external API

## Environment variable requirements

This content needs to have the following environment variable set to function:
- `AIRNOW_API_KEY` an API key from the [AirNow API service](https://docs.airnowapi.org/).
 
This variable can be saved in an .Renviron config file when working with this project.

Add the variables to that file in the format `KEY=VALUE` and save it. Restart the session so the new environment variables will be loaded with `ctrl shift f10` or through the RStudio IDE through the **Session** dropdown and selecting **Restart R**.

## Usage

Setup the `renv` environment:

```r
renv::activate()
renv::restore()
```

To render the report locally open `email/aqi_processing.Rmd` and use the "Knit" button on the top of the IDE code pane and select "Knit to HTML".

To render an email preview locally use:

```r
rmarkdown::render("email/aqi_processing.Rmd")
```

## Deployment

### Push Button

Open `email/aqi_processing.Rmd` and use the blue publish icon in the upper right corner of the IDE code pane. Ensure you select "Publish document with source code" and include all of the .Rmd documents.

### rsconnect package

You can also deploy using the rsconnect package (this assumes you have AIRNOW_API_KEY defined in your .Renviorn file first):

```
rsconnect::deployDoc(
  doc = "email/aqi_processing.Rmd",
  envVars = c("AIRNOW_API_KEY")
)
```

### Git-backed

Update the code, and then run:

```r
rsconnect::writeManifest(
  appDir = "email", 
  appPrimaryDoc = "aqi_processing.Rmd",
  appFiles = c("email_bad_air.rmd", "email_good_air.rmd", "blue_skies.jpeg", "hazy.jpeg")
)
```

Commit the new `manifest.json` file to the git repo along with the code.

## Resources

[Posit Connect User Guide: Email Customization](https://docs.posit.co/connect/user/rmarkdown/index.html#r-markdown-email-customization)
[Posit Solutions: Custom Emails with R Markdown and Blastula](https://solutions.posit.co/write-code/blastula/index.html)
[Pointblank R Package Documentation](https://rstudio.github.io/pointblank/)








### Git-backed

Update the *manifest.json* file:

```r
rsconnect::writeManifest(appPrimaryDoc = "customized_emails.Rmd")
```

Then commit any changes to git. The report will automatically redeploy.

### Programatic

You can also deploy the app using the `rsconnect` api:

```r
rsconnect::deployDoc(
  doc = "customized_emails.Rmd"
)
```
