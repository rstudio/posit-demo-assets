# Scheduled Email Outputs with `blastula` to Monitor Air Quality

A demo of using a combination of `blastula`, `rmarkdown` and `pointblank` to create a schedulable report to continuously monitor air quality and email based on certain conditions.

-   Use `blastula` to create different customized emails that will
    replace the default email sent by Posit Connect
-   Use `blastula` to choose the email output depending on condition
-   Use `pointblank` to perform data validation from an external API


## Usage

Setup the `renv` environment:

```r
renv::activate()
renv::restore()
```

To render the report locally open `aqi_processing.Rmd` and use the "Knit" button on the top of the IDE code pane and select "Knit to HTML".

To render an email preview locally use:

```r
rmarkdown::render("aqi_processing.Rmd")
```

## Deployment

### Push Button

Open `aqi_processing.Rmd` and use the blue publish icon in the upper right corner of the IDE code pane. Ensure you select "Publish document with source code" and include all of the .Rmd documents.

### rsconnect package

You can also deploy using the rsconnect package (this assumes you have AIRNOW_API_KEY defined in your .Renviorn file first):

```
rsconnect::deployDoc(
  doc = "aqi_processing.Rmd")
```

### Git-backed

Update the code, and then run:

```r
rsconnect::writeManifest(
  appPrimaryDoc = "aqi_processing.Rmd",
  appFiles = c("email_bad_air.rmd", "email_good_air.rmd", "blue_skies.jpeg", "hazy.jpeg", "stations.csv")
)
```

Commit the new `manifest.json` file to the git repo along with the code.

## Resources

[Posit Connect User Guide: Email Customization](https://docs.posit.co/connect/user/rmarkdown/index.html#r-markdown-email-customization)
[Posit Solutions: Custom Emails with R Markdown and Blastula](https://solutions.posit.co/write-code/blastula/index.html)
[Pointblank R Package Documentation](https://rstudio.github.io/pointblank/)

