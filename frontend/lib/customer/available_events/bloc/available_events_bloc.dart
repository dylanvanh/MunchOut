import 'package:bloc/bloc.dart';
import 'package:customer_repository/customer_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'available_events_event.dart';
part 'available_events_state.dart';

class AvailableEventsBloc
    extends Bloc<AvailableEventsEvent, AvailableEventsState> {
  AvailableEventsBloc({
    required UserRepository userRepository,
    required CustomerRepository customerRepository,
  })  : _userRepository = userRepository,
        _customerRepository = customerRepository,
        super(AvailableEventsLoading()) {
    on<LoadAvailableEvents>(_onLoadAvailableEvents);
    on<SwipeLeft>(_onSwipeLeft);
    on<RefreshEvents>(_onRefreshEvents);
    on<SuccessfulBooking>(_onSuccessfulBooking);
  }

  final UserRepository _userRepository;
  final CustomerRepository _customerRepository;

  //fetches the list of bookings
  Future<void> _onLoadAvailableEvents(
    LoadAvailableEvents event,
    Emitter<AvailableEventsState> emit,
  ) async {
    try {
      //retrieve the customerId
      final customerId = _userRepository.getUser().id!;

      //retrieve the list of available events
      final availableEventsList = await _customerRepository.getAvailableEvents(
        customerId: customerId,
      );

      //determine the number of total events
      final currentNumEvents = availableEventsList.length;

      // checks if at least 1 event is returned
      if (0 < currentNumEvents) {
        emit(
          AvailableEventsLoaded(
            availableEventsList: availableEventsList,
            numEvents: currentNumEvents,
            eventIndex: 0,
          ),
        );
      } else {
        emit(AvailableEventsEmpty());
      }
    } on Exception {
      //change to error encountered state
      emit(AvailableEventsErrorEncountered());
    }
  }

  //fetches the list of bookings
  //loads the next event
  void _onSwipeLeft(
    SwipeLeft event,
    Emitter<AvailableEventsState> emit,
  ) {
    try {
      final state = this.state;

      if (state is AvailableEventsLoaded) {
        final updatedEventIndex = state.eventIndex + 1;

        if (updatedEventIndex < state.numEvents) {
          emit(
            AvailableEventsLoaded(
              availableEventsList: state.availableEventsList,
              numEvents: state.numEvents,
              eventIndex: updatedEventIndex,
            ),
          );
        } else {
          emit(AvailableEventsEmpty());
        }
      }
    } on Exception {
      //change to error encountered state
      emit(AvailableEventsErrorEncountered());
    }
  }

  //handles what happens after the alertdialog pops back to the main page
  Future<void> _onSuccessfulBooking(
    SuccessfulBooking event,
    Emitter<AvailableEventsState> emit,
  ) async {
    final state = this.state;

    if (state is AvailableEventsLoaded) {
      final updatedEventIndex = state.eventIndex + 1;

      if (updatedEventIndex < state.numEvents) {
        emit(
          AvailableEventsLoaded(
            availableEventsList: state.availableEventsList,
            numEvents: state.numEvents,
            eventIndex: updatedEventIndex,
          ),
        );
      } else {
        emit(AvailableEventsEmpty());
      }
    }
  }

  //refresh button clicked
  /// SETS THE customerRepository currentAvailableEventCount = 0
  Future<void> _onRefreshEvents(
    RefreshEvents event,
    Emitter<AvailableEventsState> emit,
  ) async {
    try {
      //retrieve the customer id
      final customerId = _userRepository.getUser().id!;

      //retrieve potentially updated list of events
      final availableEventsList = await _customerRepository.getAvailableEvents(
        customerId: customerId,
      );

      //determine the new number of events
      final numEvents = availableEventsList.length;

      //if there are no events
      if (numEvents == 0) {
        //load state eventsEmpty
        emit(AvailableEventsEmpty());
      } else {
        //if there are events

        //reload the AvailableEventsLoaded state
        emit(
          AvailableEventsLoaded(
            availableEventsList: availableEventsList,
            numEvents: numEvents,
            // reset event index
            eventIndex: 0,
          ),
        );
      }
    } on Exception {
      //change to error encountered state
      emit(AvailableEventsErrorEncountered());
    }
  }
}
