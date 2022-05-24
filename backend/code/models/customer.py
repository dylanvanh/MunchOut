from db import db


class CustomerModel(db.Model):

    __tablename__ = 'customer'

    id = db.Column(db.Integer, primary_key=True)  # AUTO INCREMENTING
    name = db.Column(db.String(80))
    username = db.Column(db.String(255))
    password = db.Column(db.String(255))
    phone_number = db.Column(db.String(10))
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
    def check_if_exists(cls, name, username):

        # check if password already exists
        existing_customer = cls.query.filter_by(name=name).first()
        if existing_customer:
            return True

        # check if username already exists
        existing_username = cls.query.filter_by(username=username).first()
        if existing_username:
            return True

        return False

    def save_to_db(self):
        db.session.add(self)
        db.session.commit()
