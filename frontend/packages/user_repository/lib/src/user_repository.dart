import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flask_api/flask_api.dart'; //declared in pubspec
import 'package:user_repository/user_repository.dart';

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

  //called by login bloc
  Future<void> userLogin({
    required String username,
    required String password,
    required UserType userType,
  }) async {
    ///helper function for seperating customer/restaurant login calls
    Future<Map<String, dynamic>> _getUserData() async {
      switch (userType) {
        case UserType.customer:
          final customerUserResponse = await _flaskApi.customerLogin(
            username,
            password,
          );
          final decodedCustomerUserDetails =
              jsonDecode(customerUserResponse) as Map<String, dynamic>;

          return decodedCustomerUserDetails;

        case UserType.restaurant:
          final restaurantUserResponse = await _flaskApi.restaurantLogin(
            username,
            password,
          );

          final decodedRestaurantUserDetails =
              jsonDecode(restaurantUserResponse) as Map<String, dynamic>;

          return decodedRestaurantUserDetails;
      }
    }

    try {
      final decodedUserDetails = await _getUserData();

      User validatedUser;
      if (userType == UserType.customer) {
        //customer user
        validatedUser = User(
          id: decodedUserDetails['id'] as int,
          name: decodedUserDetails['name'] as String,
          username: decodedUserDetails['username'] as String,
          phoneNumber: decodedUserDetails['phone_number'] as String,
          userType: UserType.customer,
          authStatus: AuthenticationStatus.authenticated,
        );
      } else {
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

      //emits the new user object in the stream when it changes
      _controller.add(_validatedUser);

      // return _validatedUser;
    } on Exception {
      throw Exception();
    }
  }

  // Future<void> signUp({
  //   required String username,
  //   required String password,
  //   required UserType userType,
  // }) async {
  //   try {
  //     //post request with /register endpoint
  //     await _flaskApi.signUpUser(username, password);

  //     //login the newly created user
  //     await logIn(username: username, password: password);
  //   } on Exception {
  //     throw Exception();
  //   }
  // }
}

/// FOR TESTING
Future<void> main() async {
  final _userRepo = UserRepository();
  try {
    final userDetails = _userRepo.userLogin(
      username: 'dylan',
      password: '1234',
      userType: UserType.restaurant,
    );

    // print(userDetails);

    // print('Username = ${validatedUserInstance.username}');
    // print('authToken = ${validatedUserInstance.authToken}');

    // final user2 = _userRepo.getUser();
    // print('user2 = ${user2.username}');
  } on Exception {
    print('Invalid name and password combo');
  }
}
