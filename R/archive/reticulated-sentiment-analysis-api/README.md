# Sentiment Analysis with Plumber and spaCy

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

To run the API locally select `plumber.R` and either use the "Run API" button on the top right of the IDE code pane or use:

```r
plumber::pr("plumber.R") |>
  plumber::pr_run()
```

## Deployment

### Push Button

Open `plumber.R` and use the blue publish icon in the upper right corner of the IDE code pane.

### Git-backed

Update the code, and then run:

```r
rsconnect::writeManifest()
```

Commit the new `manifest.json` file to the git repo along with the code.

## Training

This example has a pre-created `model` directory. If you wish to re-run the training then run the `train.Rmd` script.

## Resources

- [Posit Connect User Guide: Plumber](https://docs.posit.co/connect/user/plumber/)
- [Deploying Reticulated Content](https://solutions.rstudio.com/r/reticulate/#setting-up-a-reticulated-project)
