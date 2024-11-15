## Getting Started with Flask and Posit Connect

This application structure and set-up follows the steps outlined in the links below.

Two routes are defined:

- `/` renders an HTML template
- `/api/hello` returns a JSON object

![screenshot of flask app](getting-started-flask.png)

## Usage

### The uv way

Use [uv](https://github.com/astral-sh/uv). It will detect that this is a project and create the venv for us when we go to run the application. 

Run the application:

```bash
uv run flask --app app run
```

### The pip way

Setup the `venv` environment:

```bash
python -m venv .venv
. .venv/bin/activate
pip install -r requirements.txt
```

Run the API:

```bash
flask --app app run
```

## Deploy

### rsconnect-python CLI

```bash
# With uv
uv run rsconnect deploy api .
# Without uv
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

#### Resources

- [Posit Connect User Guide: Flask](https://docs.posit.co/connect/user/flask/)
- [Getting Started with Flask and Posit Connect](https://support.rstudio.com/hc/en-us/articles/360044700234)
- [Deploying Flask Applications to Posit Connect with Git and rsconnect-python](https://support.rstudio.com/hc/en-us/articles/360045224233)
- [Using Templates and Static Assets with Flask Applications on Posit Connect](https://support.rstudio.com/hc/en-us/articles/360045279313)
