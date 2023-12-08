# Data Visualization with Streamlit

![example streamlit app screenshot](streamlit-income-share.png)

## Usage

```bash
python -m venv .venv
. .venv/bin/activate
pip install -r requirements.txt
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
