from flask_restful import Resource, reqparse
from models.event import EventModel


# Returns individual event details
class Event(Resource):
    def get(self, event_id):
        event = EventModel.query.filter_by(id=event_id).first()

        if event:
            return event.json(), 200
        return {'message': 'Event not found'}, 404


# Creates a new event
class AddEvent(Resource):

    parser = reqparse.RequestParser()

    parser.add_argument('restaurant_id',
                        type=int,
                        required=True,
                        help="This field cannot be left blank!"
                        )

    parser.add_argument('name',
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

    def post(self):
        data = AddEvent.parser.parse_args()

        # if customer already exists
        if EventModel.check_if_exists(data['restaurant_id'], data['name'],):
            return {'message': "An existing event already exists"}, 400

        new_event = EventModel(**data)

        try:
            new_event.save_to_db()
        except:
            # exception thrown
            # Internal Server Error
            return {"message": "An error occured creating the event"}, 500

        # returns the items JSON data with status code
        return new_event.json(), 201


# Returns all customers details that have a booking for the event_id
class RestaurantEventBookings(Resource):
    def get(self, event_id):

        # retrieve the event matching the specified event_id in the request
        event = EventModel.query.filter_by(id=event_id).first()

        # if an event with the specified id is not found
        if not event:
            return {'error': "event not found"}, 404

        # create empty list of customers
        customer_object_list = []

        # create empty list which is used to keep the number of attendees for a bookign
        num_attendees_list = []

        # loop through the bookings in the event
        for event_booking in event.bookings:
            num_attendees_list.append(event_booking.num_attendees)
            customer_object_list.append(event_booking.customer)

        #will be used to create a list of maps
        final_event_bookings = []
        #loop through all customers 
        for customer_object in customer_object_list:
            #add the customerId,customer_name,phone_number as a map to the list
            final_event_bookings.append(
                {
                    'customer_id': customer_object.id, 'customer_name': customer_object.name,
                    'phone_number': customer_object.phone_number
                }
            )

        #used for keeping track of the index needed
        count = 0
        #add the number of attendees for the booking to the existing maps in the list
        for customer_details in final_event_bookings:
            customer_details['numAttendees'] = num_attendees_list[count]
            count += 1

        #used to sort the list of maps
        def sort_key(d):
            return d['customer_id']

        #sort the list of maps by the customer_id 
        list_bookings_sorted_by_latest_added = sorted(
            final_event_bookings, key=sort_key, reverse=True)
        
        #return the list of bookedCustomer details
        return {'bookedCustomers': list_bookings_sorted_by_latest_added}, 200


# returns all events
class EventList(Resource):
    def get(self):
        event_list = []
        for event in EventModel.query.all():
            event_json = event.json()
            event_list.append(event_json)
        return {'events': event_list}, 200
