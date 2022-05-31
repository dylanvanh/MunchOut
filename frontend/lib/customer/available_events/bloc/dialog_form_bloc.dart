import 'package:bloc/bloc.dart';
import 'package:customer_repository/customer_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:user_repository/user_repository.dart';

import '../available_events.dart';

part 'dialog_form_event.dart';
part 'dialog_form_state.dart';

class DialogFormBloc extends Bloc<DialogFormEvent, DialogFormState> {
  DialogFormBloc({
    required UserRepository userRepository,
    required CustomerRepository customerRepository,
    required int eventId,
  })  : _userRepository = userRepository,
        _customerRepository = customerRepository,
        _eventId = eventId,
        super(const DialogFormState()) {
    on<DialogFormNumAttendeesChanged>(_onDialogNumAttendeesChanged);
    on<DialogFormSubmitted>(_onSubmitted);
  }

  final UserRepository _userRepository;
  final CustomerRepository _customerRepository;
  final int _eventId;
  // final AvailableEventsBloc _availableEventsBloc;

  void _onDialogNumAttendeesChanged(
    DialogFormNumAttendeesChanged event,
    Emitter<DialogFormState> emit,
  ) {
    final numAttendees = NumAttendees.dirty(event.numAttendees);
    emit(
      state.copyWith(
        numAttendees: numAttendees,
        status: Formz.validate([numAttendees]),
      ),
    );
  }

  Future<void> _onSubmitted(
    DialogFormSubmitted event,
    Emitter<DialogFormState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        final customerId = _userRepository.getUser().id;

        final numAttendeesFormValue = state.numAttendees.value;

        final numAttendeesInt = int.parse(numAttendeesFormValue);

        await _customerRepository.createBooking(
          eventId: _eventId,
          customerId: customerId!,
          numAttendees: numAttendeesInt,
        );

        // //to show the next event when popped back to available event page
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
