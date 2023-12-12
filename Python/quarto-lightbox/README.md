# Quarto With the Jupyter Engine and Lightbox Extension

## Usage

Setup the `venv` environment:

```bash
python -m venv .venv
. .venv/bin/activate
pip install -r requirements.txt
```

- Open the `quarto-python-lightbox.qmd` file for interactive use.
- Chose the just created `.venv` as the selected kernel.
- Click "Preview"

## Deploy

### rsconnect-python CLI

```bash
rsconnect deploy quarto .
```

### Git-backed

Update the code, and then run:

```bash
rsconnect write-manifest quarto --overwrite .
```

Commit the new `manifest.json` file to the git repo along with the code.

## Resources

- [Posit Connect User Guide: Quarto (Python)](https://docs.posit.co/connect/user/publishing-cli-quarto/)
- [quarto cli](https://quarto.org/docs/publishing/rstudio-connect.html)
- [rsconnect](https://github.com/rstudio/rsconnect)
- [rsconnect-python](https://github.com/rstudio/rsconnect-python)
- [quarto projects](https://quarto.org/docs/projects/quarto-projects.html)
- [Posit Connect User Guide - Git Backed Publishing ](https://docs.posit.co/connect/user/git-backed/)
- [Quarto Version Manager](https://github.com/dpastoor/qvm)
- [Lightbox Quarto Extension](https://github.com/quarto-ext/lightbox)
