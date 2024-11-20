# Interactive Data Visualization with Jupyter Notebooks

## Usage

### The uv way

Use [uv](https://github.com/astral-sh/uv). It will detect that this is a project and create the venv for us when we go to run the application. 

Run the application:

```bash
cd Python/jupyter-interactive-visualization

# Create the kernel
uv run ipython kernel install --user --name=project
```

- Open the `bqplot.ipynb`, `ipyvolume.ipynb`, or `hash.ipynb` file for interactive use.
- Chose the just created kernel (you may need to refresh).
- Click "Run All"

### The pip way

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
# With uv
uv export -o requirements.txt --no-hashes
uv run rsconnect write-manifest notebook --overwrite jupyter-interactive-visualization.ipynb
# Without uv
pip freeze > requirements.txt 
rsconnect write-manifest notebook --overwrite jupyter-interactive-visualization.ipynb
```

Commit the new `manifest.json` file to the git repo along with the code.

## Resources 

[Posit Connect User Guide - Jupyter](https://docs.posit.co/connect/user/jupyter-notebook/)
