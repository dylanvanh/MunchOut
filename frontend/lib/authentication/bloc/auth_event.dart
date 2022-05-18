part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class GetActiveUserDetailsEvent extends AuthEvent {
  GetActiveUserDetailsEvent({required this.user});
  final User user;
}

// Called when submit details pressed on login_page
class ValidateLoginDetailsEvent extends AuthEvent {
  const ValidateLoginDetailsEvent(
      {required this.username, required this.password});

  final String username;
  final String password;

  @override
  List<Object> get props => [username, password];
}

//When logout is clicked
class LogoutEvent extends AuthEvent {}

class AuthoriseUserEvent extends AuthEvent {
  const AuthoriseUserEvent({required this.user});

  final User user;

  @override
  List<Object> get props => [user];
}
