import 'package:bloc/bloc.dart';
import 'package:customer_repository/customer_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'available_events_event.dart';
part 'available_events_state.dart';

class AvailableEvents extends Bloc<AvailableEventsEvent, AvailableEventsState> {
  AvailableEvents({
    required UserRepository userRepository,
    required CustomerRepository customerRepository,
  })  : _userRepository = userRepository,
        _customerRepository = customerRepository,
        // initial state on bloc load
        super(AvailableEventsLoading()) {
    on<LoadAvailableEvents>(_onLoadAvailableEvents);
  }

  final UserRepository _userRepository;
  final CustomerRepository _customerRepository;

  //fetches the list of bookings
  Future<void> _onLoadAvailableEvents(
    LoadAvailableEvents event,
    Emitter<AvailableEventsState> emit,
  ) async {
    try {
      final customerId = _userRepository.getUser().id!;

      final availableEventsList = await _customerRepository.getAvailableEvents(
        customerId: customerId,
      );

      emit(AvailableEventsLoaded(availableEventsList));
    } on Exception {
      //change to error encountered state
      emit(AvailableEventsErrorEncountered());
    }
  }
}
