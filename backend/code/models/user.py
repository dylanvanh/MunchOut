from db import db
class UserModel(db.Model):
    # db table creation
    __tablename__ = 'users'

    # db columns
    id = db.Column(db.Integer, primary_key=True) #AUTO INCREMENTING
    username = db.Column(db.String(80))
    password = db.Column(db.String(80))

    def __init__(self, username, password):
        self.username = username
        self.password = password

    def save_to_db(self):
        db.session.add(self)
        db.session.commit()

    # returns the USER object using an received USERNAME
    @classmethod
    def find_by_username(cls, username):
        # returns an ItemModel object
        return cls.query.filter_by(username=username).first()

    # returns the USER object using an received ID
    @classmethod
    def find_by_id(cls, _id):
        # _id as id is a reserved word for python
        return cls.query.filter_by(id=_id).first()
 