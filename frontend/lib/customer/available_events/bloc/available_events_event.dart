part of 'available_events_bloc.dart';

abstract class AvailableEventsEvent extends Equatable {
  const AvailableEventsEvent();

  @override
  List<Object> get props => [];
}

class LoadAvailableEvents extends AvailableEventsEvent {}

// start a booking process for the current event card
// finger starts on left and goes right
class SwipeRight extends AvailableEventsEvent {
  const SwipeRight({
    required this.eventId,
    required this.restaurantId,
  });

  final int eventId;
  final int restaurantId;

  @override
  List<Object> get props => [eventId, restaurantId];
}

// ignore the currently shown even card , load the next one
// finger starts on right and goes left
class SwipeLeft extends AvailableEventsEvent {
  const SwipeLeft({
    required this.availableEventsList,
    required this.currentEventIndex,
  });

  //events that are active for the current day for the restaurant
  final List<AvailableEvent>? availableEventsList;
  final int currentEventIndex;
}

class RefreshEvents extends AvailableEventsEvent {}

class SuccessfulBooking extends AvailableEventsEvent {}

//reloads all available events - ones that the customer created a booking for
class SwipeDown extends AvailableEventsEvent {}
