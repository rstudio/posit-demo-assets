# Interactive Data Visualization with Jupyter Notebooks

## Usage

Setup the `venv` environment:

```bash
python -m venv .venv
. .venv/bin/activate
pip install -r requirements.txt
```

- Open the `jupyter-interactive-notebook.ipynb` file for interactive use.
- Chose the just created `.venv` as the selected kernel.
- Click "Run All"

## Deploy

### rsconnect-python CLI

```bash
rsconnect deploy notebook jupyter-interactive-visualization.ipynb
```

### Git-backed

Update the code, and then run:

```bash
rsconnect write-manifest notebook --overwrite jupyter-interactive-visualization.ipynb
```

Commit the new `manifest.json` file to the git repo along with the code.

## Resources 

[Posit Connect User Guide - Jupyter](https://docs.posit.co/connect/user/jupyter-notebook/)
