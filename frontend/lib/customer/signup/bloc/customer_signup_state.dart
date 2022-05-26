part of 'customer_signup_bloc.dart';

class SignupState extends Equatable {
  const SignupState({
    this.status = FormzStatus.pure,
    this.name = const Name.pure(),
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.phoneNumber = const PhoneNumber.pure(),
  });

  final FormzStatus status;
  final Name name;
  final Username username;
  final Password password;
  final PhoneNumber phoneNumber;

  SignupState copyWith({
    FormzStatus? status,
    Name? name,
    Username? username,
    Password? password,
    PhoneNumber? phoneNumber,
  }) {
    return SignupState(
      status: status ?? this.status,
      name: name ?? this.name,
      username: username ?? this.username,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  @override
  List<Object> get props => [
        status,
        name,
        username,
        password,
        phoneNumber,
      ];
}
