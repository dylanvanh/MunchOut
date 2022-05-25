import 'dart:async';
import 'dart:convert';

import 'package:flask_api/flask_api.dart'; //declared in pubspec
import 'package:user_repository/user_repository.dart';

///
enum AuthenticationAction {
  /// if the user is requesting to log in
  login,

  /// if the user is requesting to sign up
  signup,
}

/// Stores currently logged in user
/// Communicates with the FlaskApi
class UserRepository {
  /// Constructor
  UserRepository({FlaskApi? flaskApi, User? validatedUser})
      : _flaskApi = flaskApi ?? FlaskApi(),
        _validatedUser = validatedUser ?? const User();

  final FlaskApi _flaskApi;
  final _controller = StreamController<User>();
  User _validatedUser;

  /// yields the _validatedUser when the object values change
  /// seen in signUp and login -> _controller.add(_validatedUser)
  Stream<User> get user async* {
    await Future<void>.delayed(
      const Duration(seconds: 1),
    );

    //intially empty user with Authentication.status = unauthenticated
    yield const User();

    yield* _controller.stream;
  }

  ///returns the currently "logged in" user
  User getUser() {
    return _validatedUser;
  }

  ///called by login bloc
  Future<void> customerLoginSignup({
    String? name,
    required String username, //required no matter if login/signup
    required String password, //required no matter if login/signup
    String? phoneNumber,
    String? restaurantDescription,
    String? restaurantImageUrl,
    required UserType userType, // customer || restaurant
    required AuthenticationAction authActionType,
    // login || signup
  }) async {
    /// Helper function that seperates
    /// Customer user ,restaurant user & both their login & signup logic
    /// both login&signup flask_api endpoints return the users details on success
    // _getUserData returns their retrieved data
    Future<Map<String, dynamic>> _getUserData() async {
      // try{}
      switch (userType) {

        // customer trying to login / signup
        case UserType.customer:
          switch (authActionType) {
            // customer login
            case AuthenticationAction.login:
              final customerUserResponse = await _flaskApi.customerLogin(
                username,
                password,
              );
              final decodedCustomerUserDetails =
                  jsonDecode(customerUserResponse) as Map<String, dynamic>;

              return decodedCustomerUserDetails;

            // customer signup
            case AuthenticationAction.signup:
              final customerUserResponse = await _flaskApi.customerSignup(
                name!, // ! -> says that it wont be passed as null (null safety)
                username,
                password,
                phoneNumber!,
              );
              final decodedCustomerUserDetails =
                  jsonDecode(customerUserResponse) as Map<String, dynamic>;

              return decodedCustomerUserDetails;
          }

        // restaurant trying to login / signup
        case UserType.restaurant:
          switch (authActionType) {

            // restaurant login
            case AuthenticationAction.login:
              final restaurantUserResponse = await _flaskApi.restaurantLogin(
                username,
                password,
              );
              final decodedRestaurantUserDetails =
                  jsonDecode(restaurantUserResponse) as Map<String, dynamic>;

              return decodedRestaurantUserDetails;

            // restaurant signup
            case AuthenticationAction.signup:
              final restaurantUserResponse = await _flaskApi.restaurantSignup(
                name!, // ! -> says that it wont be passed as null (null safety)
                username,
                password,
                restaurantDescription!,
                restaurantImageUrl!,
                phoneNumber!,
              );
              final decodedRestaurantUserDetails =
                  jsonDecode(restaurantUserResponse) as Map<String, dynamic>;

              return decodedRestaurantUserDetails;
          }
      }
    }

    try {
      // retrieve decoded userDetails that was returned as a response from
      // the flask api backend
      final decodedUserDetails = await _getUserData();

      User validatedUser;

      switch (userType) {
        case UserType.customer:
          //customer user
          validatedUser = User(
            id: decodedUserDetails['id'] as int,
            name: decodedUserDetails['name'] as String,
            username: decodedUserDetails['username'] as String,
            phoneNumber: decodedUserDetails['phone_number'] as String,
            userType: UserType.customer,
            authStatus: AuthenticationStatus.authenticated,
          );
          break;

        case UserType.restaurant:
          //restaurant user
          validatedUser = User(
            id: decodedUserDetails['id'] as int,
            name: decodedUserDetails['name'] as String,
            username: decodedUserDetails['username'] as String,
            phoneNumber: decodedUserDetails['phone_number'] as String,
            restaurantImageUrl: decodedUserDetails['image_url'] as String,
            restaurantDescription: decodedUserDetails['description'] as String,
            userType: UserType.restaurant,
            authStatus: AuthenticationStatus.authenticated,
          );
      }

      //set the user object to the previouslyFetched validated user on "login/start"
      _validatedUser = validatedUser;

      //emits the new user object in the stream
      //when any _validatedUser (User) object data changes
      _controller.add(_validatedUser);

      // return _validatedUser;
    } on Exception {
      throw Exception();
    }
  }
}

/// FOR TESTING
// Future<void> main() async {
//   final _userRepo = UserRepository();
//   try {
//     //signup
//     // await _userRepo.customerLoginSignup(
//     //   name: 'casey',
//     //   phoneNumber: '092823',
//     //   username: 'casey',
//     //   password: '1234',
//     //   userType: UserType.customer,
//     //   authActionType: AuthenticationAction.signup,
//     // );

//     //login
//     // await _userRepo.customerLoginSignup(
//     //   username: 'casey',
//     //   password: '1234',
//     //   userType: UserType.customer,
//     //   authActionType: AuthenticationAction.login,
//     // );
//   } on Exception {
//     print('error');
//   }
// }
