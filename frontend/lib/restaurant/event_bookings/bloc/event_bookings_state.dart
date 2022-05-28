part of 'event_bookings_bloc.dart';

abstract class EventBookingsState extends Equatable {
  const EventBookingsState();

  @override
  List<Object?> get props => [];
}

/// State while list of events are been fetched
class EventBookingsLoading extends EventBookingsState {}

/// State when list of events succesfully fetched
class EventBookingsLoaded extends EventBookingsState {
  const EventBookingsLoaded(this.customersBookedList);

  //events that are active for the current day for the restaurant
  final List<Booking>? customersBookedList;

  @override
  List<Object?> get props => [customersBookedList];
}

/// State when error encountered during fetching of events
class EventBookingsErrorEncountered extends EventBookingsState {}
