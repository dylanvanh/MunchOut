import hmac  # replaces from werkzeug.security import safe_str_cmp

from models.user import UserModel


# when the user accesses the /auth end point
# check if received username and password match a version stored in Users table in DB
def authenticate(username, password):
    # if no user found -> None
    user = UserModel.find_by_username(username)
    # if user != None and entered password matches saved password
    if user and hmac.compare_digest(user.password, password):
        return user  # return the user object which is used to generate the JWT token in app.py JWT()

# whenever an endpoint is accessed with authentication required
# receive payload from request
def identity(payload):
    # receive the userID in the payload
    user_id = payload['identity']
    # retrieve the userID using the user_id mapping
    return UserModel.find_by_id(user_id)
