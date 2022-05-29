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
  const AvailableEventsLoaded(this.availableEventsList);

  //events that are active for the current day for the restaurant
  final List<AvailableEvent>? availableEventsList;

  @override
  List<Object?> get props => [availableEventsList];
}

/// State when error encountered during fetching of events
class AvailableEventsErrorEncountered extends AvailableEventsState {}
