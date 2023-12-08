# Data Visualization with Shiny for Python

![example shiny app screenshot](shiny-income-share.png)

## Usage

```bash
python -m venv .venv
. .venv/bin/activate
pip install -r requirements.txt
shiny run --reload app.py
```

## Deploy

### rsconnect-python CLI

```bash
rsconnect deploy shiny .
```

### Git-backed

Update the code, and then run:

```bash
rsconnect write-manifest shiny --overwrite .
```

Commit the new `manifest.json` file to the git repo along with the code.

## Resources

[Posit Connect User Guide: Shiny for Python](https://docs.posit.co/connect/user/shiny-python/)
