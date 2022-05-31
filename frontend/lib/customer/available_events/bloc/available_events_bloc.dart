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

      // update the number of events in the customerRepository
      // used to provide number of events when incrementing currentEventIndex
      _customerRepository.updateNumEvents(currentNumEvents);

      // retrievve the current index, (useful if the page was accsessed prior)
      final currentEventIndex = _customerRepository.getCurrentEventIndex();

      //if the total number of events is greater than the total number of events
      // list of length 4 [0,1,2,3] max index should be 3
      if (currentEventIndex <= currentNumEvents) {
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
  //loads the next item
  void _onSwipeLeft(
    SwipeLeft event,
    Emitter<AvailableEventsState> emit,
  ) {
    try {
      final state = this.state;

      if (state is AvailableEventsLoaded) {
        final numEvents = _customerRepository.getNumEvents();

        //set the currentVventIndex to +1 -> points it to the next event
        _customerRepository.incrementCurrentEventIndex();

        final updatedEventIndex = _customerRepository.getCurrentEventIndex();

        //if the total number of events is greater than the total number of events
        // list of length 4 [0,1,2,3] max index should be 3
        if (updatedEventIndex < numEvents) {
          emit(
            AvailableEventsLoaded(
              availableEventsList: state.availableEventsList,
              numEvents: numEvents,
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

      // final state = this.state;

      //create booking
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

    //retrieve the total number of events
    final numEvents = _customerRepository.getNumEvents();

    //increments the currentEvent index to the next item
    // (To not show the event that was just booked for)
    final updatedEventIndex = _customerRepository.incrementCurrentEventIndex();

    if (state is AvailableEventsLoaded) {
      print('numEvents= ${state.numEvents}');
      print('initialEventIndex= ${state.eventIndex}');
      print('updatedEventIndex = $updatedEventIndex');

      if (updatedEventIndex < numEvents) {
        emit(
          AvailableEventsLoaded(
            availableEventsList: state.availableEventsList,
            numEvents: numEvents,
            eventIndex: updatedEventIndex,
          ),
        );
        print(
            'repo eventIndex eventIndex=${_customerRepository.getCurrentEventIndex()}');
      } else {
        emit(AvailableEventsEmpty());
      }
    }
  }

  /// pull down / refresh button clicked
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

      //update the repository numEvents variable
      _customerRepository.updateNumEvents(numEvents);

      //if there are no events
      if (numEvents == 0) {
        //load state eventsEmpty
        emit(AvailableEventsEmpty());
      } else {
        //if there are events
        //reset the respository eventIndex to 0
        _customerRepository.resetCurrentEventIndex();

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
