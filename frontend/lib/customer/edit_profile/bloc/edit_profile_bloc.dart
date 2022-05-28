import 'package:bloc/bloc.dart';
import 'package:customer_repository/customer_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:itdma3_mobile_app/restaurant/edit_profile/edit_profile.dart';
import 'package:user_repository/user_repository.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc({
    required UserRepository userRepository,
    required CustomerRepository customerRepository,
  })  : _userRepository = userRepository,
        _customerRepository = customerRepository,
        super(const EditProfileState()) {
    on<EditProfileNameChanged>(_onNameChanged);
    on<EditProfilePasswordChanged>(_onPasswordChanged);
    on<EditProfilePhoneNumberChanged>(_onPhoneNumberChanged);
    on<EditProfileSubmitted>(_onSubmitted);
  }

  final UserRepository _userRepository;
  final CustomerRepository _customerRepository;

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
        final customerUserId = _userRepository.getUser().id;

        // pass new details, using existing restauranUserId
        // Updates the details in the db
        await _customerRepository.updateUserDetails(
          customerId: customerUserId!,
          name: state.name.value,
          password: state.password.value,
          phoneNumber: state.phoneNumber.value,
        );

        // Requests the new data from the db
        // Updates the user object in _userRepository using the updated details
        await _userRepository.updateDetails(userType: UserType.customer);

        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
