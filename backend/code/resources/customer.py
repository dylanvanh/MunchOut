from datetime import datetime
from flask_restful import Resource, reqparse
from sqlalchemy import false
from models.customer import CustomerModel
from models.event import EventModel
from db import db

# Returns an individual customers details
class Customer(Resource):

    parser = reqparse.RequestParser()

    parser.add_argument('id',
                        type=int,
                        help="This field cannot be left blank!"
                        )

    parser.add_argument('name',
                        help="This field cannot be left blank!"
                        )

    parser.add_argument('password',
                        help="This field cannot be left blank!"
                        )

    parser.add_argument('phone_number',
                        help="This field cannot be left blank!"
                        )

    def get(self, customer_id):
        customer = CustomerModel.query.filter_by(id=customer_id).first()

        if customer:
            return customer.json(), 200
        return {'message': 'Customer not found'}, 404

    # update customer details
    # returns the updated customer details
    def patch(self, customer_id):
        data = Customer.parser.parse_args()

        exisiting_customer = CustomerModel.query.filter_by(
            id=customer_id).first()

        if data['name']:
            exisiting_customer.name = data['name']

        if data['password']:
            exisiting_customer.password = data['password']

        if data['phone_number']:
            exisiting_customer.phone_number = data['phone_number']

        try:
            db.session.commit()
        except:
            # exception thrown
            # Internal Server Error
            return {"message": "An error occured updating the customer"}, 500

        # returns the items JSON data with status code
        return exisiting_customer.json(), 201


# Returns a customers details if valid credentials provided
class CustomerLogin(Resource):

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

        data = CustomerLogin.parser.parse_args()

        existing_customer = CustomerModel.query.filter_by(
            username=data['username'], password=data['password']).first()

        if existing_customer:
            return existing_customer.json(), 200

        return {'message': "Invalid details entered"}, 400


# Creates a new customer
# Returns newly created customer details , if an existing customer with same details doesn't exist
class CustomerSignup(Resource):

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
    parser.add_argument('phone_number',
                        required=True,
                        help="This field cannot be left blank!"
                        )

    def post(self):
        data = CustomerSignup.parser.parse_args()

        # if customer already exists
        if CustomerModel.check_if_exists(data['username']):
            return {'message': "A customer with existing details already exists"}, 400

        # Same as CustomerModel(data['name],data['username].....)
        new_customer = CustomerModel(**data)

        try:
            new_customer.save_to_db()
        except:
            # exception thrown
            # Internal Server Error
            return {"message": "An error occured creating the customer"}, 500

        # returns the items JSON data with status code
        return new_customer.json(), 201


# Returns all the events a customer has a booking for (sorted by booking ID)
class CustomerBookedEvents(Resource):

    def get(self, customer_id):
        customer = CustomerModel.query.filter_by(id=customer_id).first()

        if not customer:
            return {"error ": "customer not found"}, 404

       # list of booking objects that the customer has
        booking_list = []

        # retrieve all the booking objects from the customer object (bookings)
        for booking in customer.bookings:
            booking_list.append(booking)

        # event objects that the customer has
        event_object_list = []
        # retrieve all the event objects from the booking objects (events)
        for booking_object in booking_list:
            event_object = booking_object.event
            event_object_list.append(event_object)

        final_list = []
        # loop through event objects
        for event in event_object_list:
            final_list.append(
                {
                    'event_id': event.id, 'event_name': event.name,
                    'event_description': event.description, 'event_date': str(event.date),
                    'event_image_url': event.image_url
                })

        # add the num_attendees value to each dictionary in the final_list
        count = 0  # keeps track of the increment in num_attendees
        for individual_object_details in final_list:
            individual_object_details['booking_id'] = booking_list[count].id
            individual_object_details['booking_num_attendees'] = booking_list[count].num_attendees
            individual_object_details['restaurant_id'] = event_object_list[count].restaurant.id
            individual_object_details['restaurant_name'] = event_object_list[count].restaurant.name
            individual_object_details['restaurant_description'] = event_object_list[count].restaurant.description
            individual_object_details['restaurant_image_url'] = event_object_list[count].restaurant.image_url
            individual_object_details['restaurant_phone_number'] = event_object_list[count].restaurant.phone_number

            count += 1

        def sort_key(d):
            return d['booking_id']

        list_booking_events_sorted_by_latest_added = sorted(
            final_list, key=sort_key, reverse=True)

        return {'customerEvents': list_booking_events_sorted_by_latest_added}, 200


# Returns all the events for today that have not been booked already by the individual customer
class CustomerAvailableEvents(Resource):

    def get(self, customer_id):

        # filter by date
        date_today = datetime.now().date()

        # get a list of customer_event_id's
        customer = CustomerModel.query.filter_by(id=customer_id).first()

        # get the bookings_list for the customer for today
        bookings_list = []
        for booking in customer.bookings:
            if booking.date == date_today:
                bookings_list.append(booking)

        # get the events the user has a booking for today
        customer_event_list = []
        for booking in bookings_list:
            customer_event_list.append(booking.event)

        # get a list of all events for today
        all_events = EventModel.query.filter_by(date=str(date_today)).all()

        # compare the users events to all available events
        available_events_list = set(all_events) - set(customer_event_list)

        final_list = []
        for event in available_events_list:
            final_list.append(
                {
                    'event_id': event.id, 'event_name': event.name,
                    'event_image_url': event.image_url, 'event_description': event.description,
                    'event_date': str(event.date), 'restaurant_id': event.restaurant.id,
                    'restaurant_name': event.restaurant.name, 'restaurant_image_url': event.restaurant.image_url,
                }
            )

        # returns the available event detail objects in a random order , as they are in a set
        return {'customerAvailableEvents': final_list}, 200

# Returns a list of all customers
class CustomerList(Resource):
    def get(self):
        customer_list = []
        for customer in CustomerModel.query.all():
            customer_json = customer.json()
            customer_list.append(customer_json)
        return {'customers': customer_list}, 200
