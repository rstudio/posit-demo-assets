import spacy
from flask import Flask, request, jsonify
import os
app = Flask(__name__)
if 'RS_SERVER_URL' in os.environ and os.environ['RS_SERVER_URL']:
  from werkzeug.middleware.proxy_fix import ProxyFix
  app.wsgi_app = ProxyFix(app.wsgi_app, x_prefix=1)

model_dir = "model"

@app.route('/')
def predict():
    input = request.args.get("input", "This is a wonderful movie!")
    nlp = spacy.load(model_dir)
    doc = nlp(input)
    result = (input, doc.cats)
    return jsonify(result)

if __name__ == '__main__':
    app.run()
