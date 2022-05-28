part of 'events_bloc.dart';

abstract class BookingsState extends Equatable {
  const BookingsState();

  @override
  List<Object?> get props => [];
}

/// State while list of events are been fetched
class BookingsLoading extends BookingsState {}

/// State when list of events succesfully fetched
class BookingsLoaded extends BookingsState {
  const BookingsLoaded(this.bookingsList);

  //events that are active for the current day for the restaurant
  final List<BookedEvent>? bookingsList;

  @override
  List<Object?> get props => [bookingsList];
}

/// State when error encountered during fetching of events
class BookingsErrorEncountered extends BookingsState {}
