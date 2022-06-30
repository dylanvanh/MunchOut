from email.mime import image
from sqlalchemy import desc
from db import db


class RestaurantModel(db.Model):

    __tablename__ = 'restaurant'

    # AUTO INCREMENTING
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(255))
    username = db.Column(db.String(255))
    password = db.Column(db.String(255))
    description = db.Column(db.String(255))
    image_url = db.Column(db.String(255))
    phone_number = db.Column(db.String(255))

    # list of events , flask created object
    events = db.relationship('EventModel', overlaps="restaurant")

    def __init__(self, name, username, password, description, image_url, phone_number):
        self.name = name
        self.username = username
        self.password = password
        self.description = description
        self.image_url = image_url
        self.phone_number = phone_number

    def json(self):
        return {
            'id': self.id, 'name': self.name, 'username': self.username,
            'description': self.description, 'image_url': self.image_url,
            'phone_number': self.phone_number
        }

    @classmethod
    def check_if_exists(cls,username):
        
        # check if username already exists
        existing_restaurant = cls.query.filter_by(username=username).first()
        if existing_restaurant:
            return True
        return False

    def save_to_db(self):
        db.session.add(self)
        db.session.commit()
