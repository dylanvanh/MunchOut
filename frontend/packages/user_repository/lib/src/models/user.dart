///status options of the user
enum AuthenticationStatus {
  /// set when the user is unathenticated (not logged in)
  unauthenticated,

  /// set when the user is authenticated (logged in)
  authenticated,
}

/// User model
class User {
  ///User contructor
  ///User auth status intially set to unauthenticated
  const User({
    this.username,
    this.authToken,
    this.authStatus = AuthenticationStatus.unauthenticated,
  });

  /// Unique username for the user
  /// Used as a primary key
  final String? username;

  /// Unique auth token for the user
  final String? authToken;

  ///status of the user
  final AuthenticationStatus authStatus;

  @override
  String toString() {
    return 'Username : $username - AuthToken : $authToken';
  }
}
