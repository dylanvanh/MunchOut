from flask_restful import Resource, reqparse
from models.restaurant import RestaurantModel
from db import db

# Returns individual restaurant details
class Restaurant(Resource):

    parser = reqparse.RequestParser()

    parser.add_argument('name',
                        help="This field cannot be left blank!"
                        )
    parser.add_argument('password',
                        help="This field cannot be left blank!"
                        )
    parser.add_argument('description',
                        help="This field cannot be left blank!"
                        )
    parser.add_argument('image_url',
                        help="This field cannot be left blank!"
                        )
    parser.add_argument('phone_number',
                        help="This field cannot be left blank!"
                        )

    def get(self, restaurant_id):
        restaurant = RestaurantModel.query.filter_by(id=restaurant_id).first()

        if restaurant:
            return restaurant.json()
        return {'message': 'Customer not found'}, 404

    # update restaurant details
    # returns the updated restaurant details
    def patch(self, restaurant_id):
        data = Restaurant.parser.parse_args()

        existing_restaurant = RestaurantModel.query.filter_by(
            id=restaurant_id).first()

        if data['name']:
            existing_restaurant.name = data['name']

        if data['password']:
            existing_restaurant.password = data['password']

        if data['description']:
            existing_restaurant.description = data['description']

        if data['image_url']:
            existing_restaurant.image_url = data['image_url']

        if data['phone_number']:
            existing_restaurant.phone_number = data['phone_number']

        try:
            db.session.commit()
        except:
            # exception thrown
            # Internal Server Error
            return {"message": "An error occured updating the restaurant"}, 500

        # returns the items JSON data with status code
        return existing_restaurant.json(), 201


# Returns a restaurants details if valid credentials provided
class RestaurantLogin(Resource):

    parser = reqparse.RequestParser()

    parser.add_argument('username',
                        required=True,
                        help="This field cannot be left blank!"
                        )

    parser.add_argument('password',
                        required=True,
                        help="This field cannot be left blank!"
                        )

    def post(self):

        data = RestaurantLogin.parser.parse_args()

        existing_restaurant = RestaurantModel.query.filter_by(
            username=data['username'], password=data['password']).first()

        if existing_restaurant:
            return existing_restaurant.json()

        return {'message': "Invalid details entered"}, 400


# Returns newly created customer details , if an existing customer with same details doesn't exist
class RestaurantSignup(Resource):

    parser = reqparse.RequestParser()

    parser.add_argument('name',
                        required=True,
                        help="This field cannot be left blank!"
                        )

    parser.add_argument('username',
                        required=True,
                        help="This field cannot be left blank!"
                        )
    parser.add_argument('password',
                        required=True,
                        help="This field cannot be left blank!"
                        )
    parser.add_argument('description',
                        required=True,
                        help="This field cannot be left blank!"
                        )
    parser.add_argument('image_url',
                        required=True,
                        help="This field cannot be left blank!"
                        )
    parser.add_argument('phone_number',
                        required=True,
                        help="This field cannot be left blank!"
                        )

    def post(self):
        data = RestaurantSignup.parser.parse_args()

        # if restaurant already exists
        if RestaurantModel.check_if_exists(data['name'], data['username']):
            return {'message': "A restaurant with existing details already exists"}, 400

        new_restaurant = RestaurantModel(**data)

        try:
            new_restaurant.save_to_db()
        except:
            # exception thrown
            # Internal Server Error
            return {"message": "An error occured creating the restaurant"}, 500

        # returns the items JSON data with status code
        return new_restaurant.json(), 201

# Returns the individual restaurants currently active events (todays events)
class RestaurantEvents(Resource):
    def get(self, restaurant_id):
        restaurant = RestaurantModel.query.filter_by(id=restaurant_id).first()

        if not restaurant:
            return {"error": "restaurant doesnt exist"}

        event_object_list = []

        # retrieve all the booking objects from the restaurant object (events)
        for restaurant_event in restaurant.events:
            event_object_list.append(restaurant_event)

        final_list = []

        for event in event_object_list:
            final_list.append(
                {
                    'event_id': event.id, 'restaurant_id': restaurant.id,
                    'name': event.name, 'description': event.description,
                    'image_url': event.image_url, 'date': str(event.date)
                }
            )

        return {'restaurant events': final_list}


# Returns a list of all restaurants
class RestaurantList(Resource):
    def get(self):
        restaurant_list = []
        for restaurant in RestaurantModel.query.all():
            restaurant_json = restaurant.json()
            restaurant_list.append(restaurant_json)
        return {'restaurants': restaurant_list}
