from datetime import datetime
from db import db


class BookingModel(db.Model):

    __tablename__ = 'booking'

    # AUTO INCREMENTING
    id = db.Column(db.Integer, primary_key=True)

    event_id = db.Column(db.Integer, db.ForeignKey('event.id'), nullable=False)
    # event object , that matches the event_id
    event = db.relationship('EventModel', overlaps="customer")

    customer_id = db.Column(db.Integer, db.ForeignKey(
        'customer.id'), nullable=False)
    # customer object, that matches the customer_id
    customer = db.relationship('CustomerModel', overlaps="customer")

    num_attendees = db.Column(db.Integer)

    # date value created by python
    date = db.Column(db.Date, default=datetime.now().date)

    def __init__(self, event_id, customer_id, num_attendees):
        self.event_id = event_id
        self.customer_id = customer_id
        self.num_attendees = num_attendees

    def json(self):
        return {
            'id': self.id, 'event_id': self.event_id,
            'customer_id': self.customer_id, 'num_attendees': self.num_attendees
        }

     # checks if an existing booking already exists
    @classmethod
    def check_if_exists(cls, customer_id, event_id):
        existing_booking = cls.query.filter_by(
            customer_id=customer_id, event_id=event_id).first()
        # if booking exists
        if existing_booking:
            return True
        # booking doesnt exist
        return False

    def save_to_db(self):
        db.session.add(self)
        db.session.commit()
