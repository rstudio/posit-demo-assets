# Data Analysis and Visualization with pandas and ggplot2

Read more about using reticulate with R Markdown: https://rstudio.github.io/reticulate/articles/r_markdown.html

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

To render the dashboard either open `rmarkdown-notebook.Rmd` use the "Knit" button on the top of the IDE code pane and select "Knit to HTML" or use:

```r
rmarkdown::render("rmarkdown-notebook.Rmd")
```

## Deployment

### Push Button

Open `rmarkdown-notebook.Rmd` and use the blue publish icon in the upper right corner of the IDE code pane.

### rsconnect package

You can also deploy using the rsconnect package:

```
rsconnect::deployDoc(
  doc = "rmarkdown-notebook.Rmd",
  appTitle = "R Markdown Reticulate Example"
)
```

### Git-backed

Update the code, and then run:

```r
rsconnect::writeManifest()
```

Commit the new `manifest.json` file to the git repo along with the code.

## Resources

- [Posit Connect User Guide: R Markdown](https://docs.posit.co/connect/user/rmarkdown/)
- [Deploying Reticulated Content](https://solutions.rstudio.com/r/reticulate/#setting-up-a-reticulated-project)


