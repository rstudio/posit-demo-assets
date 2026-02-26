Create and use virtual environment
```bash
/path/to/python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

Deployment via git:
```
rsconnect write-manifest quarto script.py
git commit -A .
git push
```