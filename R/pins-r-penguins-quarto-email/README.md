# Using Pins, Quarto, and sending emails with Penguins Data

A demo of using pins with Posit Pro Products.

## Environment variable requirements

This content needs to have the following environment variables set to function:
- `CONNECT_SERVER` the URL of your Connect server, for Test Drive it will be in this format: https://YOUR_DOMAIN_HERE.eval.posit.co/cnct
- `CONNECT_API_KEY` an API key from your Connect server. See [API Keys](https://docs.posit.co/connect/user/api-keys/) in the Connect User guide for more information.
 
For your convenience, both of these environment variables are already set in Test Drive sessions (put in `~/.bash_profile`). This content should work without further action from within the Test Drive environment.

## Usage

Setup the `renv` environment:

```r
renv::activate()
renv::restore()
```

To render the dashboard either open `report/pins-r-penguins.Rmd` and use the "Knit" button on the top of the IDE code pane and select "Knit to HTML" or use:

```bash
quarto render
```

## Deployment

### Push Button

Open `pins-r-penguins-quarto-email.qmd` and use the blue publish icon in the upper right corner of the IDE code pane.

### rsconnect package

You can also deploy using the rsconnect package:

```
rsconnect::deployDoc(
  doc = "pins-r-penguins-quarto-email.qmd",
  appTitle = "R Pins, Quarto, and Email Example"
)
```

### Git-backed

Update the code, and then run:

```r
rsconnect::writeManifest(
  appFiles = c("pins-r-penguins-quarto-email.qmd")
)
```

Commit the new `manifest.json` file to the git repo along with the code.

## Resources

[Posit Connect How-to Guide: Pins](https://docs.posit.co/connect/how-to/pins/)
[Posit Connect How-to Guide: Emails](https://quarto.org/docs/prerelease/1.4/email.html)
