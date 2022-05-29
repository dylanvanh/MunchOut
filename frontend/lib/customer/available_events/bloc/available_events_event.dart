part of 'available_events_bloc.dart';

abstract class AvailableEventsEvent extends Equatable {
  const AvailableEventsEvent();

  @override
  List<Object> get props => [];
}

class LoadAvailableEvents extends AvailableEventsEvent {}
