# Loan Risk Prediction Model using FastAPI

## Usage

### The uv way

Use [uv](https://github.com/astral-sh/uv). It will detect that this is a project and create the venv for us when we go to run the application. 

Run the application:

```bash
uv run uvicorn main:app --reload
```

### The pip way

Setup the `venv` environment:

```bash
python -m venv .venv
. .venv/bin/activate
pip install -r requirements.txt
```

Run the API (to see the OpenAPI Documentation go to the proxied servers tab and add `/docs` to the URL):

```bash
uvicorn main:app --reload
```

## Deploy

### rsconnect-python CLI

```bash
# With uv
uv run rsconnect deploy fastapi .
# Without uv
rsconnect deploy fastapi .
```

### Git-backed

Update the code, and then run:

```bash
# With uv
uv export -o requirements.txt --no-hashes
uv run rsconnect write-manifest fastapi --overwrite .
# Without uv
pip freeze > requirements.txt 
rsconnect write-manifest fastapi --overwrite .
```

Commit the new `manifest.json` file to the git repo along with the code.

## Training

This example has a pre-created `model` directory. If you wish to re-run the training then run the `train.ipynb` notebook.

## Resources

[FastAPI Docs](https://fastapi.tiangolo.com/)
[Posit Connect User Guide: FastAPI](https://docs.posit.co/connect/user/fastapi/)
