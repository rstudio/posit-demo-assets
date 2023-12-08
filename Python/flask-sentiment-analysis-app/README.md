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
rsconnect write-manifest api --overwrite .
```

Commit the new `manifest.json` file to the git repo along with the code.

## Resources

[Posit Connect User Guide: Flask](https://docs.posit.co/connect/user/flask/)
