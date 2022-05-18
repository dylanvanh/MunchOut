part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class UnauthorisedState extends AuthState {}

class AuthorisedState extends AuthState {
  const AuthorisedState({required this.validatedUser});

  // username & authToken
  final User validatedUser;

  @override
  List<Object> get props => [validatedUser];
}
