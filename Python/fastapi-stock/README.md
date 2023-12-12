# Serving Stock Information with FastAPI 

## Usage

Setup the `venv` environment:

```bash
python -m venv .venv
. .venv/bin/activate
pip install -r requirements.txt
```

Run the API:

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

## Resources

[FastAPI Docs](https://fastapi.tiangolo.com/)
[Posit Connect User Guide: FastAPI](https://docs.posit.co/connect/user/fastapi/)
