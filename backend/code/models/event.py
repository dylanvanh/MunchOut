from datetime import datetime
from db import db


class EventModel(db.Model):

    __tablename__ = 'event'

    # AUTO INCREMENTING
    id = db.Column(db.Integer, primary_key=True)  # AUTO INCREMENTING

    # foreign_key
    restaurant_id = db.Column(db.Integer, db.ForeignKey(
        'restaurant.id'), nullable=False)
    restaurant = db.relationship('RestaurantModel')

    name = db.Column(db.String(255))
    description = db.Column(db.String(255))
    image_url = db.Column(db.String(255))
    # date value created by python
    date = db.Column(db.Date, default=datetime.now().date)

    # list of booking objects , flask created objects
    # all booking items with the event_id as a foreign_key
    bookings = db.relationship('BookingModel', overlaps="event")

    def json(self):
        return {
            'id': self.id, 'restaurant_id': self.restaurant_id,
            'name': self.name, 'description': self.description,
            'image_url': self.image_url, 'date': str(self.date)
        }

    @classmethod
    def check_if_exists(cls, restaurant_id, name):
        # check if event already exists for current restaurant for today
        existing_event = cls.query.filter_by(
            restaurant_id=restaurant_id, name=name, date=datetime.now().date()).first()

        if existing_event:
            return True

        return False

    def save_to_db(self):
        db.session.add(self)
        db.session.commit()
