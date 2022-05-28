part of 'events_bloc.dart';

abstract class EventsState extends Equatable {
  const EventsState();

  @override
  List<Object?> get props => [];
}

/// State while list of events are been fetched
class EventsLoading extends EventsState {}

/// State when list of events succesfully fetched
class EventsLoaded extends EventsState {
  const EventsLoaded(this.eventsList);

  //events that are active for the current day for the restaurant
  final List<Event>? eventsList;

  @override
  List<Object?> get props => [eventsList];
}

/// State when error encountered during fetching of events
class EventsErrorEncountered extends EventsState {}
