# Custom Conditional Email Outputs with `blastula`

A demo of using a combination of `blastula` and `knitr::exit()` to generate different outcomes when rendering a report on Posit Connect. The main document, `customized_emails.Rmd` will 

-   Use `blastula` to create different customized emails that will
    replace the default email sent by Posit Connect
-   Use `blastula` to suppress email output depending on condition
-   Use `knitr::knit_exit()` to stop executing code and exit the
    report rendering on condition

Notable code features include embedding the generated email in the report, which is useful for logging purposes.

## Usage

Setup the `renv` environment:

```r
renv::activate()
renv::restore()
```

To render the report locally open `email/customized_emails.Rmd` and use the "Knit" button on the top of the IDE code pane and select "Knit to HTML".

To render an email preview locally use:

```r
rmarkdown::render("email/customized_emails.Rmd")
```

## Deployment

### Push Button

Open `email/customized_emails.Rmd` and use the blue publish icon in the upper right corner of the IDE code pane. Ensure you select "Publish document with source code" and include all of the .Rmd documents.

### rsconnect package

You can also deploy using the rsconnect package:

```
rsconnect::deployDoc(
  doc = "email/customized_emails.Rmd"
)
```

### Git-backed

Update the code, and then run:

```r
rsconnect::writeManifest(
  appDir = "email", 
  appPrimaryDoc = "customized_emails.Rmd",
  appFiles = c("case1_email.Rmd", "case2_email.Rmd", "case4_email.Rmd")
)
```

Commit the new `manifest.json` file to the git repo along with the code.

## Resources

[Posit Connect User Guide: Email Customization](https://docs.posit.co/connect/user/rmarkdown/index.html#r-markdown-email-customization)
[Posit Solutions: Custom Emails with R Markdown and Blastula](https://solutions.posit.co/write-code/blastula/index.html)









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
