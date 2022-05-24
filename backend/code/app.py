from flask import Flask
from flask_restful import Api
from resources.customer import Customer, CustomerLogin, CustomerSignup, CustomerBookedEvents, CustomerAvailableEvents, CustomerList
from resources.restaurant import Restaurant, RestaurantLogin, RestaurantSignup, RestaurantEvents, RestaurantList
from resources.event import Event, AddEvent, RestaurantEventBookings, EventList
from resources.booking import Booking, AddBooking, BookingList
from db import db

app = Flask(__name__)
app.config["SQLALCHEMY_DATABASE_URI"] = "mysql://admin:root@localhost/itmda3"
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.secret_key = 'dylan'
api = Api(app)


if __name__ == "__main__":
    db.init_app(app)
    app.run(port=5000, debug=True, host='127.0.0.1')
