# Stock Pricing Dashboard

## About this example

A Dash application makes it easy to transform your analysis into an interactive dashboard using Python so users can ask and answer questions in real-time, without having to touch any code.

![example app image](dash-stock-pricing.png)

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

## Learn more

* [Dash User Guide](https://dash.plotly.com/)
* [Posit Connect User Guide: Dash](https://docs.posit.co/connect/user/dash/)
