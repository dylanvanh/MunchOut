part of 'available_events_bloc.dart';

abstract class AvailableEventsEvent extends Equatable {
  const AvailableEventsEvent();

  @override
  List<Object> get props => [];
}

class LoadAvailableEvents extends AvailableEventsEvent {}

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
