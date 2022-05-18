from flask import Flask
from flask_restful import Api
from flask_jwt import JWT

from security import authenticate, identity
from resources.user import UserRegister
from db import db

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///data.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.secret_key = 'dylan'
api = Api(app)


@app.before_first_request
# creates all tables , unless they exist already
def create_tables():
    db.create_all()


# automatically creates a new endpoint /auth
jwt = JWT(app, authenticate, identity)

# resources & end points
api.add_resource(UserRegister, '/register')


if __name__ == "__main__":
    db.init_app(app)
    # ipv4 address, localhost doesnt work with mobile emulator
    app.run(port=5000, debug=True, host='192.168.1.160')
