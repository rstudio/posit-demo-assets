# Interactive Notebooks with Voilà

Voilà allows you to convert a Jupyter Notebook into an interactive dashboard.

![example screenshot of voila](voila.png)

## Notebooks Included

- Example visualizations using [bqplot](./bqplot.ipynb) and [ipyvolume](./ipyvolume.ipynb)
- A brief introduction to [secure hashes](./hash.ipynb)

## Usage

### The uv way 

Use [uv](https://github.com/astral-sh/uv). It will detect that this is a project and create the venv for us when we go to run the application. 

```bash
cd Python/jupyter-voila

# Create the kernel
uv run ipython kernel install --user --name=project

# List the available kernels
jupyter kernelspec list
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

- Open the `bqplot.ipynb`, `ipyvolume.ipynb`, or `hash.ipynb` file for interactive use.
- Chose the just created `.venv` as the selected kernel.
- Click "Run All"

## Deploy

### rsconnect-python CLI

```bash
# With uv
uv run rsconnect deploy voila . --multi-notebook
# Without uv
rsconnect deploy voila . --multi-notebook
```

### Git-backed

Update the code, and then run:

```bash
# With uv
uv export -o requirements.txt --no-hashes
uv run rsconnect write-manifest voila --overwrite . --multi-notebook
# Without uv
pip freeze > requirements.txt 
rsconnect write-manifest voila --overwrite . --multi-notebook
```

Commit the new `manifest.json` file to the git repo along with the code.

## Resources

- [Posit Connect User Guide - Voilà](https://docs.posit.co/connect/user/publishing-cli-notebook/#interactive-voila-deployment)
