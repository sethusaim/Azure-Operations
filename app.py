from flask import Flask

from src.constant import APP_HOST, APP_PORT

app = Flask(__name__)


@app.route("/")
def hello():
    return "Hello, World!"


@app.route("/first")
def first():
    return "This is first page"


if __name__ == "__main__":
    app.run(host=APP_HOST, port=APP_PORT)
