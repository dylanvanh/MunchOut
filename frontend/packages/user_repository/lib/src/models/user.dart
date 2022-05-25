///status options of the user
enum AuthenticationStatus {
  /// set when the user is unathenticated (not logged in)
  unauthenticated,

  /// set when the user is authenticated (logged in)
  authenticated,
}

/// User types that are possible for a logged in user
enum UserType {
  ///set when customer user type
  customer,

  /// set when restaurant user type
  restaurant,
}

/// User model
class User {
  ///User contructor
  ///User auth status intially set to unauthenticated
  const User({
    required this.id,
    required this.name,
    required this.username,
    required this.phoneNumber,
    this.restaurantImageUrl, // only gets a value if type =  restaurant user
    this.restaurantDescription, // only gets a value if type =  restaurant user
    required this.userType,
    this.authStatus = AuthenticationStatus.unauthenticated,
  });

  /// user id created by flask
  final int id;

  /// name entered by the user
  final String name;

  /// username that is used for signin
  final String username;

  /// phoneNumber for contact details
  final String phoneNumber;

  /// image url of the restaurant for display
  final String? restaurantImageUrl;

  /// short description of the restuarant
  final String? restaurantDescription;

  /// Type of user (either customer / restaurant)
  final UserType userType;

  ///Authentication status of the user
  final AuthenticationStatus authStatus;

  @override
  String toString() {
    return 'Base user details : $id , $name , $username , $userType';
  }
}
