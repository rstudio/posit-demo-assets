# Sentiment Analysis with spaCy and Shiny

## Usage

Create a `.Renviron` file to set `RETICULATE_PYTHON`:

```bash
echo "RETICULATE_PYTHON=.venv/bin/python" >> .Renviron
```

Setup the `venv` environment:

```bash
python -m venv .venv
. .venv/bin/activate
pip install -r requirements.txt
deactivate
```

Setup the `renv` environment:

```r
renv::activate()
renv::restore()
```

To run the app locally select `app/app.R` and either use the "Run App" button on the top right of the IDE code pane or use:

```r
shiny::runApp()
```

## Deployment

### Push Button

Use the blue publish icon in the upper right corner of the IDE code pane.

### rsconnect package

You can also deploy using the rsconnect package:

```
rsconnect::deployApp(
  appTitle = "Sentiment Analysis Shiny App using Reticulate"
)
```

### Git-backed

Update the code, and then run:

```r
rsconnect::writeManifest()
```

Commit the new `manifest.json` file to the git repo along with the code.

## Training

This example has a pre-created `model` directory. If you wish to re-run the training then run the `train.Rmd` script.

## Resources

- [Posit Connect User Guide - Shiny](https://docs.posit.co/connect/user/shiny/)
- [Deploying Reticulated Content](https://solutions.rstudio.com/r/reticulate/#setting-up-a-reticulated-project)


