import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:itdma3_mobile_app/restaurant/edit_profile/edit_profile.dart';
import 'package:restaurant_repository/restaurant_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc({
    required UserRepository userRepository,
    required RestaurantRepository restaurantRepository,
  })  : _userRepository = userRepository,
        _restaurantRepository = restaurantRepository,
        super(const EditProfileState()) {
    on<EditProfileNameChanged>(_onNameChanged);
    on<EditProfilePasswordChanged>(_onPasswordChanged);
    on<EditProfilePhoneNumberChanged>(_onPhoneNumberChanged);
    on<EditProfileDescriptionChanged>(_onDescriptionChanged);
    on<EditProfileImageUrlChanged>(_onImageUrlChanged);
    on<EditProfileSubmitted>(_onSubmitted);
  }

  final UserRepository _userRepository;
  final RestaurantRepository _restaurantRepository;

  void _onNameChanged(
    EditProfileNameChanged event,
    Emitter<EditProfileState> emit,
  ) {
    final name = Name.dirty(event.name);
    emit(
      state.copyWith(
        name: name,
        status: Formz.validate([
          name,
          state.password,
          state.phoneNumber,
          state.description,
          state.imageUrl,
        ]),
      ),
    );
  }

  void _onPasswordChanged(
    EditProfilePasswordChanged event,
    Emitter<EditProfileState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate([
          password,
          state.name,
          state.phoneNumber,
          state.description,
          state.imageUrl,
        ]),
      ),
    );
  }

  void _onPhoneNumberChanged(
    EditProfilePhoneNumberChanged event,
    Emitter<EditProfileState> emit,
  ) {
    final phoneNumber = PhoneNumber.dirty(event.phoneNumber);
    emit(
      state.copyWith(
        phoneNumber: phoneNumber,
        status: Formz.validate([
          phoneNumber,
          state.name,
          state.password,
          state.description,
          state.imageUrl,
        ]),
      ),
    );
  }

  void _onDescriptionChanged(
    EditProfileDescriptionChanged event,
    Emitter<EditProfileState> emit,
  ) {
    final description = Description.dirty(event.description);
    emit(
      state.copyWith(
        description: description,
        status: Formz.validate([
          description,
          state.name,
          state.password,
          state.phoneNumber,
          state.imageUrl,
        ]),
      ),
    );
  }

  void _onImageUrlChanged(
    EditProfileImageUrlChanged event,
    Emitter<EditProfileState> emit,
  ) {
    final imageUrl = ImageUrl.dirty(event.imageUrl);
    emit(
      state.copyWith(
        imageUrl: imageUrl,
        status: Formz.validate([
          imageUrl,
          state.name,
          state.password,
          state.phoneNumber,
          state.description,
        ]),
      ),
    );
  }

  //passes details to user repository for new user creation
  Future<void> _onSubmitted(
    EditProfileSubmitted event,
    Emitter<EditProfileState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        // get the current restaurantId , to use for other requests
        final restaurantUserId = _userRepository.getUser().id;

        // pass new details, using existing restauranUserId
        // Updates the details in the db
        await _restaurantRepository.updateUserDetails(
          restaurantId: restaurantUserId!,
          name: state.name.value,
          password: state.password.value,
          phoneNumber: state.phoneNumber.value,
          description: state.description.value,
          imageUrl: state.imageUrl.value,
        );

        // Requests the new data from the db
        // Updates the user object in _userRepository using the updated details
        await _userRepository.updateDetails(userType: UserType.restaurant);

        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
