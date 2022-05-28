part of 'active_events_bloc.dart';

abstract class ActiveEventsState extends Equatable {
  const ActiveEventsState();

  @override
  List<Object?> get props => [];
}

/// State while list of events are been fetched
class ActiveEventsLoading extends ActiveEventsState {}

/// State when list of events succesfully fetched
class ActiveEventsLoaded extends ActiveEventsState {
  const ActiveEventsLoaded(this.activeEventList);

  //events that are active for the current day for the restaurant
  final List<Event>? activeEventList;

  @override
  List<Object?> get props => [activeEventList];
}

/// State when error encountered during fetching of events
class ActiveEventsErrorEncountered extends ActiveEventsState {}
