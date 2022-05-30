part of 'available_events_bloc.dart';

abstract class AvailableEventsState extends Equatable {
  const AvailableEventsState();

  @override
  List<Object?> get props => [];
}

/// State while list of events are been fetched
class AvailableEventsLoading extends AvailableEventsState {}

/// State when list of events succesfully fetched
class AvailableEventsLoaded extends AvailableEventsState {
  const AvailableEventsLoaded({
    required this.availableEventsList,
    required this.numEvents,
    required this.eventIndex,
  });

  //events that are active for the current day for the restaurant
  final List<AvailableEvent>? availableEventsList;

  final int numEvents;

  final int eventIndex;

  @override
  List<Object?> get props => [availableEventsList, eventIndex];
}

// State when the list of available events is empty (no more left to view)
class AvailableEventsEmpty extends AvailableEventsState {}

/// State when error encountered during fetching of events
class AvailableEventsErrorEncountered extends AvailableEventsState {}
