part of 'event_bookings_bloc.dart';

abstract class EventBookingsEvent extends Equatable {
  const EventBookingsEvent();

  @override
  List<Object> get props => [];
}

class LoadEventBookings extends EventBookingsEvent {}
