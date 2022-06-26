from flask_restful import Resource, reqparse
from models.booking import BookingModel


# Returns an individual bookings details
class Booking(Resource):
    def get(self, booking_id):
        booking = BookingModel.query.filter_by(id=booking_id).first()

        if booking:
            return booking.json(), 200
        return {'message': 'Booking not found'}, 404


# Creates a new booking
class AddBooking(Resource):

    parser = reqparse.RequestParser()

    parser.add_argument('event_id',
                        type=int,
                        required=True,
                        help="This field cannot be left blank!"
                        )

    parser.add_argument('customer_id',
                        type=int,
                        required=True,
                        help="This field cannot be left blank!"
                        )
    parser.add_argument('num_attendees',
                        type=int,
                        required=True,
                        help="This field cannot be left blank!"
                        )

    def post(self):
        data = AddBooking.parser.parse_args()

        # if customer already exists
        if BookingModel.check_if_exists(data['customer_id'], data['event_id']):
            return {'message': "An existing booking already exists"}, 400

        new_booking = BookingModel(**data)

        try:
            new_booking.save_to_db()
        except:
            # exception thrown
            # Internal Server Error
            return {"message": "An error occured creating the booking"}, 500

        # returns the items JSON data with status code
        return new_booking.json(), 201


# Returns a list of all bookings
class BookingList(Resource):
    def get(self):
        booking_list = []
        for booking in BookingModel.query.all():
            booking_json = booking.json()
            booking_list.append(booking_json)
        return {'bookings': booking_list}, 200
