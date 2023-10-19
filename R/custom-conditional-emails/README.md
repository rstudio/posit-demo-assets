# Custom Conditional Email Outputs with `blastula`

A demo of using a combination of `blastula` and `knitr::exit()` to generate different outcomes when rendering a report on Posit Connect.  The main document, `customized_emails.Rmd` will 

-   Use `blastula` to create different customized emails that will
    replace the default email sent by Posit Connect

-   Use `blastula` to suppress email output depending on condition

-   Use `knitr::knit_exit()` to stop executing code and exit the
    report rendering on condition


Notable code features include embedding the generated email in the report, which is useful for logging purposes.

## Usage

Render the report in RStudio:

```r
rmarkdown::render("customized_emails.Rmd")
```

## Deployment

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
