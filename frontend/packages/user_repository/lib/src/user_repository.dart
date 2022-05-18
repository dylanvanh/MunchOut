import 'dart:async';
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
  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    try {
      //returns an auth token if details valid
      //doesnt save the password
      final authToken = await _flaskApi.requestAuthToken(username, password);
      final validatedUser = User(
          username: username,
          authToken: authToken.accessToken,
          authStatus: AuthenticationStatus.authenticated);

      //set the user object to the previouslyFetched validated user on "login/start"
      _validatedUser = validatedUser;

      //emits the new user object in the stream when it changes
      _controller.add(_validatedUser);

      // return _validatedUser;
    } on Exception {
      throw Exception();
    }
  }

  Future<void> signUp({
    required String username,
    required String password,
  }) async {
    try {
      //post request with /register endpoint
      await _flaskApi.signUpUser(username, password);

      //login the newly created user
      await logIn(username: username, password: password);
    } on Exception {
      throw Exception();
    }
  }
}
