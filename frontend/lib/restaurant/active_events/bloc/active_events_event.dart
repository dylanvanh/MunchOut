part of 'active_events_bloc.dart';

abstract class ActiveEventsEvent extends Equatable {
  const ActiveEventsEvent();

  @override
  List<Object> get props => [];
}

class LoadActiveEvents extends ActiveEventsEvent {}
