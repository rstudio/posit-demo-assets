# Stock Pricing Dashboard

## About this example

A Dash application makes it easy to transform your analysis into an interactive dashboard using Python so users can ask and answer questions in real-time, without having to touch any code.

![example app image](dash-stock-pricing.png)

## Usage

### The uv way

Use [uv](https://github.com/astral-sh/uv). It will detect that this is a project and create the venv for us when we go to run the application. 

Run the application:

```bash
uv run app.py
```

Stuck on the `loading...` screen? Try closing the session and re-running the above command. It seems like there can be a transient issue that happens when the environment setup and app run steps are run together. 

### The pip way

Setup the `venv` environment:

```bash
python -m venv .venv
. .venv/bin/activate
pip install -r requirements.txt
```

Run the application:

```bash
python app.py
```

## Deploy

### rsconnect-python CLI

```bash
# With uv
uv run rsconnect deploy dash .
# Without uv
rsconnect deploy dash .
```

### Git-backed

Update the code, and then run:

```bash
# With uv
uv export -o requirements.txt --no-hashes
uv run rsconnect write-manifest dash --overwrite .
# Without uv
pip freeze > requirements.txt 
rsconnect write-manifest dash --overwrite .
```

Commit the new `manifest.json` file to the git repo along with the code.

## Learn more

* [Dash User Guide](https://dash.plotly.com/)
* [Posit Connect User Guide: Dash](https://docs.posit.co/connect/user/dash/)
