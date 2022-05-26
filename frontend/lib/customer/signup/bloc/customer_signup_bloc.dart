import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:itdma3_mobile_app/customer/signup/signup.dart';
import 'package:user_repository/user_repository.dart';

part 'customer_signup_event.dart';
part 'customer_signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const SignupState()) {
    on<SignupNameChanged>(_onNameChanged);
    on<SignupUsernameChanged>(_onUsernameChanged);
    on<SignupPasswordChanged>(_onPasswordChanged);
    on<SignupPhoneNumberChanged>(_onPhoneNumberChanged);
    on<SignupSubmitted>(_onSubmitted);
  }

  final UserRepository _userRepository;

  void _onNameChanged(
    SignupNameChanged event,
    Emitter<SignupState> emit,
  ) {
    final name = Name.dirty(event.name);
    emit(
      state.copyWith(
        name: name,
        status: Formz.validate([
          name,
          state.username,
          state.password,
          state.phoneNumber,
        ]),
      ),
    );
  }

  void _onUsernameChanged(
    SignupUsernameChanged event,
    Emitter<SignupState> emit,
  ) {
    final username = Username.dirty(event.username);
    emit(
      state.copyWith(
        username: username,
        status: Formz.validate([
          username,
          state.name,
          state.password,
          state.phoneNumber,
        ]),
      ),
    );
  }

  void _onPasswordChanged(
    SignupPasswordChanged event,
    Emitter<SignupState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate([
          password,
          state.username,
          state.name,
          state.phoneNumber,
        ]),
      ),
    );
  }

  void _onPhoneNumberChanged(
    SignupPhoneNumberChanged event,
    Emitter<SignupState> emit,
  ) {
    final phoneNumber = PhoneNumber.dirty(event.phoneNumber);
    emit(
      state.copyWith(
        phoneNumber: phoneNumber,
        status: Formz.validate([
          phoneNumber,
          state.name,
          state.username,
          state.password,
        ]),
      ),
    );
  }

  //passes details to user repository for new user creation
  void _onSubmitted(
    SignupSubmitted event,
    Emitter<SignupState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        await _userRepository.userLoginSignup(
          name: state.name.value,
          username: state.username.value,
          password: state.password.value,
          phoneNumber: state.phoneNumber.value,
          userType: UserType.customer,
          authActionType: AuthenticationAction.signup,
        );
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
