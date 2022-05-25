part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class SignupNameChanged extends SignupEvent {
  const SignupNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class SignupUsernameChanged extends SignupEvent {
  const SignupUsernameChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

class SignupPasswordChanged extends SignupEvent {
  const SignupPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class SignupPhoneNumberChanged extends SignupEvent {
  const SignupPhoneNumberChanged(this.phoneNumber);

  final String phoneNumber;

  @override
  List<Object> get props => [phoneNumber];
}

class SignupDescriptionChanged extends SignupEvent {
  const SignupDescriptionChanged(this.description);

  final String description;

  @override
  List<Object> get props => [description];
}

class SignupImageUrlChanged extends SignupEvent {
  const SignupImageUrlChanged(this.imageUrl);

  final String imageUrl;

  @override
  List<Object> get props => [imageUrl];
}

class SignupSubmitted extends SignupEvent {
  const SignupSubmitted();
}
