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
        event = EventModel.query.filter_by(id=event_id).first()

        if not event:
            return {'error': "event not found"}, 404

        customer_object_list = []

        num_attendees_list = []
        for event_booking in event.bookings:
            num_attendees_list.append(event_booking.num_attendees)
            customer_object_list.append(event_booking.customer)

        final_list = []
        for customer_object in customer_object_list:
            final_list.append(
                {
                    'customer_id': customer_object.id, 'customer_name': customer_object.name,
                    'phone_number': customer_object.phone_number
                }
            )

        count = 0
        for customer_details in final_list:
            customer_details['numAttendees'] = num_attendees_list[count]
            count += 1

        return {'bookedCustomers': final_list}, 200


# returns all events
class EventList(Resource):
    def get(self):
        event_list = []
        for event in EventModel.query.all():
            event_json = event.json()
            event_list.append(event_json)
        return {'events': event_list}, 200
