# Data Visualization with Streamlit

![example streamlit app screenshot](streamlit-income-share.png)

## Usage

### The uv way

Use [uv](https://github.com/astral-sh/uv). It will detect that this is a project and create the venv for us when we go to run the application. 

Run the application:

```bash
uv run streamlit run app.py
```

### The pip way

Setup the `venv` environment:

```bash
# Create virtual environment
python -m venv .venv

# Activate virtual environment
. .venv/bin/activate

# Install all of the requirements
pip install -r requirements.txt
```

Run the application:

```bash
streamlit run app.py
```

## Deploy

### rsconnect-python CLI

```bash
# With uv
uv run rsconnect deploy streamlit .
# Without uv
rsconnect deploy streamlit .
```

### Git-backed

Update the code, and then run:

```bash
# With uv
uv run rsconnect write-manifest streamlit --overwrite .
# Without uv
rsconnect write-manifest streamlit --overwrite .
```

Commit the new `manifest.json` file to the git repo along with the code.

## Resources

[Posit Connect User Guide: Streamlit](https://docs.posit.co/connect/user/streamlit/)
