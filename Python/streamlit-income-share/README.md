# Data Visualization with Streamlit

![example streamlit app screenshot](streamlit-income-share.png)

## Usage

Setup the `venv` environment:

```bash
# Create virtual environment
python -m venv .venv

# Activate virtual environment
. .venv/bin/activate

# Install all of the requirements
pip install -r requirements.txt
```

Alternatively, use [uv](https://github.com/astral-sh/uv): 

```bash
# Create virtual environment
uv venv

# Activate virtual environment
source .venv/bin/activate

# Install all of the requirements
uv pip sync requirements.txt
```

Run the application:

```bash
streamlit run app.py
```

## Deploy

### rsconnect-python CLI

```bash
rsconnect deploy streamlit .
```

### Git-backed

Update the code, and then run:

```bash
rsconnect write-manifest streamlit --overwrite .
```

Commit the new `manifest.json` file to the git repo along with the code.
## Resources

[Posit Connect User Guide: Streamlit](https://docs.posit.co/connect/user/streamlit/)
