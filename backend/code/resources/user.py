from flask_restful import Resource, reqparse
from models.user import UserModel

class UserRegister(Resource):

    parser = reqparse.RequestParser()
    parser.add_argument('username', type=str, required=True,
                        help='This field cannot be blank')
    parser.add_argument('password', type=str, required=True,
                        help='This field cannot be blank')

    def post(self):

        # receive data from json payload
        data = UserRegister.parser.parse_args()

        # checks if username already exists
        if UserModel.find_by_username(data['username']):
            return {"message": "A user with that username already exists"}, 400

        user = UserModel(data['username'],data['password']) # UserModel(**data) -> same thing
        user.save_to_db()

        return {"message": "User created successfully"}, 201
