part of 'edit_profile_bloc.dart';

class InitialState extends Equatable {
  const InitialState();

  @override
  List<Object?> get props => [];
}

class EditProfileState extends Equatable {
  const EditProfileState({
    this.status = FormzStatus.pure,
    this.name = const Name.pure(),
    this.password = const Password.pure(),
    this.phoneNumber = const PhoneNumber.pure(),
    this.description = const Description.pure(),
    this.imageUrl = const ImageUrl.pure(),
  });

  final FormzStatus status;
  final Name name;
  final Password password;
  final PhoneNumber phoneNumber;
  final Description description;
  final ImageUrl imageUrl;

  EditProfileState copyWith({
    FormzStatus? status,
    Name? name,
    Password? password,
    PhoneNumber? phoneNumber,
    Description? description,
    ImageUrl? imageUrl,
  }) {
    return EditProfileState(
      status: status ?? this.status,
      name: name ?? this.name,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  List<Object> get props => [
        status,
        name,
        password,
        phoneNumber,
        description,
        imageUrl,
      ];
}
