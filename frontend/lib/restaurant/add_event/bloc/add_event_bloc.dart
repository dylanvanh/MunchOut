import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import 'package:itdma3_mobile_app/restaurant/add_event/add_event.dart';

import 'package:user_repository/user_repository.dart';

part 'add_event_event.dart';
part 'add_event_state.dart';

class AddEventBloc extends Bloc<AddEventEvent, AddEventState> {
  AddEventBloc({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const AddEventState()) {
    on<AddEventNameChanged>(_onNameChanged);
    on<AddEventDescriptionChanged>(_onDescriptionChanged);
    on<AddEventImageUrlChanged>(_onImageUrlChanged);
    on<AddEventSubmitted>(_onSubmitted);
  }

  final UserRepository _userRepository;

  void _onNameChanged(
    AddEventNameChanged event,
    Emitter<AddEventState> emit,
  ) {
    final name = Name.dirty(event.name);
    emit(
      state.copyWith(
        name: name,
        status: Formz.validate([
          name,
          state.description,
          state.imageUrl,
        ]),
      ),
    );
  }

  void _onDescriptionChanged(
    AddEventDescriptionChanged event,
    Emitter<AddEventState> emit,
  ) {
    final description = Description.dirty(event.description);
    emit(
      state.copyWith(
        description: description,
        status: Formz.validate([
          description,
          state.name,
          state.imageUrl,
        ]),
      ),
    );
  }

  void _onImageUrlChanged(
    AddEventImageUrlChanged event,
    Emitter<AddEventState> emit,
  ) {
    final imageUrl = ImageUrl.dirty(event.imageUrl);
    emit(
      state.copyWith(
        imageUrl: imageUrl,
        status: Formz.validate([
          imageUrl,
          state.name,
          state.description,
        ]),
      ),
    );
  }

  void _onSubmitted(
    AddEventSubmitted event,
    Emitter<AddEventState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        await _restaurantRepository.addRestaurantEvent(
          restaurantId: _userRepository.getUser().id,
          name: state.name,
          description: state.description,
          imageUrl: state.imageUrl,
        );

        // await _userRepository.userLoginSignup(
        //   username: state.username.value,
        //   password: state.password.value,
        //   userType: UserType.restaurant,
        //   authActionType: AuthenticationAction.login,
        // );
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (_) {
        print('error occured');
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
