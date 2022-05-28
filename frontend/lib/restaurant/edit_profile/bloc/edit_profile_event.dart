part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object> get props => [];
}

//fetches the current details
class FetchRestaurantDetails extends EditProfileEvent {
  const FetchRestaurantDetails();

  //calls api to load current details

}

class EditProfileNameChanged extends EditProfileEvent {
  const EditProfileNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class EditProfilePasswordChanged extends EditProfileEvent {
  const EditProfilePasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class EditProfilePhoneNumberChanged extends EditProfileEvent {
  const EditProfilePhoneNumberChanged(this.phoneNumber);

  final String phoneNumber;

  @override
  List<Object> get props => [phoneNumber];
}

class EditProfileDescriptionChanged extends EditProfileEvent {
  const EditProfileDescriptionChanged(this.description);

  final String description;

  @override
  List<Object> get props => [description];
}

class EditProfileImageUrlChanged extends EditProfileEvent {
  const EditProfileImageUrlChanged(this.imageUrl);

  final String imageUrl;

  @override
  List<Object> get props => [imageUrl];
}

class EditProfileSubmitted extends EditProfileEvent {
  const EditProfileSubmitted();
}
