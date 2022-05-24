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


@app.before_first_request
def create_tables():  # creates all tables , unless they exist already
    db.create_all()

"""
HELPER ENDPOINTS 
"""
# returns all restaurants
api.add_resource(RestaurantList, '/restaurants')

# returns all events
api.add_resource(EventList, '/events')

# returns all customers
api.add_resource(CustomerList, '/customers')

# returns all bookings
api.add_resource(BookingList, '/bookings')

# Individual booking details
api.add_resource(Booking, '/booking/<int:booking_id>')


@app.route('/')  # no endpoint specified
def get_customers():
    return {'flask-api': 'running'}



if __name__ == "__main__":
    db.init_app(app)
    #use your machines ipv4 address
    app.run(port=5000, debug=True, host='192.168.1.160')

"""
CUSTOMER ENDPOINTS
"""
# Edit customer profile screen
api.add_resource(Customer, '/customer/<int:customer_id>')

# Register customer screen
api.add_resource(CustomerSignup, '/customer_signup')

# Login customer screen
api.add_resource(CustomerLogin, '/customer_login')

# Start booking for restaurant screen , SUBMIT
api.add_resource(AddBooking, '/add_booking')

api.add_resource(Event, '/event/<int:event_id>')

# Browse daily restaurant events screen
api.add_resource(CustomerAvailableEvents,
                 '/customer_available_events/<int:customer_id>')

# View Bookings screen (shows event bookings)
api.add_resource(CustomerBookedEvents, '/customer_booked_events/<int:customer_id>')
