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
    on<SwipeRight>(_onSwipeRight);
    on<RefreshEvents>(_onRefreshEvents);
  }

  final UserRepository _userRepository;
  final CustomerRepository _customerRepository;

  //fetches the list of bookings
  Future<void> _onLoadAvailableEvents(
    LoadAvailableEvents event,
    Emitter<AvailableEventsState> emit,
  ) async {
    try {
      print('hello');
      final customerId = _userRepository.getUser().id!;

      final availableEventsList = await _customerRepository.getAvailableEvents(
        customerId: customerId,
      );

      final numEvents = availableEventsList.length;

      // update the number of events in the customerRepository
      // used to provide number of events when incrementing currentEventIndex
      _customerRepository.updateNumEvents(numEvents);

      final currentEventIndex = _customerRepository.getCurrentEventIndex();

      if (currentEventIndex < numEvents) {
        emit(
          AvailableEventsLoaded(
            availableEventsList: availableEventsList,
            numEvents: numEvents,
            eventIndex: currentEventIndex,
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
  void _onSwipeLeft(
    SwipeLeft event,
    Emitter<AvailableEventsState> emit,
  ) {
    try {
      final state = this.state;

      if (state is AvailableEventsLoaded) {
        final numEvents = state.numEvents;
        _customerRepository.incrementCurrentEventIndex(
          numEventTotal: numEvents,
        );

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

  Future<void> _onSwipeRight(
    SwipeRight event,
    Emitter<AvailableEventsState> emit,
  ) async {
    try {
      //-> route to confirm booking request booking amount
      // pop back screen to browse events after succesful event processed

      final state = this.state;

      //create booking
    } on Exception {
      //change to error encountered state
      emit(AvailableEventsErrorEncountered());
    }
  }

  /// pull down / refresh button clicked
  /// SETS THE customerRepository currentAvailableEventCount = 0
  Future<void> _onRefreshEvents(
    RefreshEvents event,
    Emitter<AvailableEventsState> emit,
  ) async {
    try {
      final customerId = _userRepository.getUser().id!;

      final availableEventsList = await _customerRepository.getAvailableEvents(
        customerId: customerId,
      );

      final numEvents = availableEventsList.length;

      _customerRepository.resetCurrentEventIndex();

      emit(
        AvailableEventsLoaded(
          availableEventsList: availableEventsList,
          numEvents: numEvents,
          // reset event index
          eventIndex: 0,
        ),
      );
    } on Exception {
      //change to error encountered state
      emit(AvailableEventsErrorEncountered());
    }
  }
}
