from flask import Flask, render_template, jsonify
import os
app = Flask(__name__)
if 'RS_SERVER_URL' in os.environ and os.environ['RS_SERVER_URL']:
  from werkzeug.middleware.proxy_fix import ProxyFix
  app.wsgi_app = ProxyFix(app.wsgi_app, x_prefix=1)

@app.route("/")
def index():
    return render_template("index.html")


@app.route("/api/hello", methods=["GET"])
def hello():
    return jsonify({"message": "right back at ya!"})
