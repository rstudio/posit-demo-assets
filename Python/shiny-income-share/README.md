# Data Visualization with Shiny for Python

![example shiny app screenshot](shiny-income-share.png)

## Usage

### The uv way

Use [uv](https://github.com/astral-sh/uv). It will detect that this is a project and create the venv for us when we go to run the application. 

Run the application:

```bash
uv run app.py
uv run shiny run --reload app.py
```

### The pip way

Setup the `venv` environment:

```bash
python -m venv .venv
. .venv/bin/activate
pip install -r requirements.txt
```

Run the application:

```bash
shiny run --reload app.py
```

## Deploy

### rsconnect-python CLI

```bash
# With uv
uv run rsconnect deploy shiny .
# Without uv
rsconnect deploy shiny .
```

### Git-backed

Update the code, and then run:

```bash
# With uv
uv export -o requirements.txt --no-hashes
uv run rsconnect write-manifest shiny --overwrite .
# Without uv
pip freeze > requirements.txt 
rsconnect write-manifest shiny --overwrite .
```

Commit the new `manifest.json` file to the git repo along with the code.

## Resources

[Posit Connect User Guide: Shiny for Python](https://docs.posit.co/connect/user/shiny-python/)
