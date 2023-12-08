# Data Visualization with Dash

This example is from Plotly's [Dash tutorial](https://dash.plot.ly/getting-started-part-2).

![example app image](app.png)

## Usage

```bash
python -m venv .venv
. .venv/bin/activate
pip install -r requirements.txt
python app.py
```

## Deploy

### rsconnect-python CLI

```bash
rsconnect deploy dash .
```

### Git-backed

Update the code, and then run:

```bash
rsconnect write-manifest dash --overwrite .
```

Commit the new `manifest.json` file to the git repo along with the code.

## Resources

[Posit Connect User Guide: Dash](https://docs.posit.co/connect/user/dash/)
