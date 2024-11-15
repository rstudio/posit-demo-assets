# Serving Sentiment Analysis with spaCy and Flask

This application exposes a model trained in spaCy via a Flask API.
A user interface for the application is also served via Flask.

## Setup

```bash
python -m venv .venv
. .venv/bin/activate
pip install -r requirements.txt
python train.py
```

## Usage

### The uv way

Use [uv](https://github.com/astral-sh/uv). It will detect that this is a project and create the venv for us when we go to run the application. 

Run the application:

```bash
uv run app.py
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
flask --app app run
```

## Deploy

### rsconnect-python CLI

```bash
rsconnect deploy api .
```

### Git-backed

Update the code, and then run:

```bash
# With uv
uv export -o requirements.txt --no-hashes
uv run rsconnect write-manifest api --overwrite .
# Without uv
pip freeze > requirements.txt 
rsconnect write-manifest api --overwrite .
```

Commit the new `manifest.json` file to the git repo along with the code.

## Resources

[Posit Connect User Guide: Flask](https://docs.posit.co/connect/user/flask/)
