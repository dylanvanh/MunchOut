from db import db


class CustomerModel(db.Model):

    __tablename__ = 'customer'

    # AUTO INCREMENTING
    id = db.Column(db.Integer, primary_key=True)  # AUTO INCREMENTING

    name = db.Column(db.String(80))

    username = db.Column(db.String(255))

    password = db.Column(db.String(255))

    phone_number = db.Column(db.String(10))

    # list of booking objects , flask created objects
    # all booking items with the customer_id as a foreign_key
    bookings = db.relationship('BookingModel', overlaps="customer")

    def __init__(self, name, username, password, phone_number):
        self.name = name
        self.username = username
        self.password = password
        self.phone_number = phone_number

    def json(self):
        return {
            'id': self.id, 'name': self.name,
            'username': self.username, 'password': self.password,
            'phone_number': self.phone_number,
        }

    @classmethod
    def check_if_exists(cls, username):

        # check if username already exists
        existing_username = cls.query.filter_by(username=username).first()
        if existing_username:
            return True

        return False

    def save_to_db(self):
        db.session.add(self)
        db.session.commit()
