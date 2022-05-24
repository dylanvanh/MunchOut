from flask import Flask
from flask_restful import Api


app = Flask(__name__)


if __name__ == "__main__":
    db.init_app(app)
    app.run(port=5000, debug=True, host='127.0.0.1')
