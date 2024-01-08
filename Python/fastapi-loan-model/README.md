# Loan Risk Prediction Model using FastAPI

## Usage

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
rsconnect deploy fastapi .
```

### Git-backed

Update the code, and then run:

```bash
rsconnect write-manifest fastapi --overwrite .
```

Commit the new `manifest.json` file to the git repo along with the code.

## Training

This example has a pre-created `model` directory. If you wish to re-run the training then run the `train.ipynb` notebook.

## Resources

[FastAPI Docs](https://fastapi.tiangolo.com/)
[Posit Connect User Guide: FastAPI](https://docs.posit.co/connect/user/fastapi/)
