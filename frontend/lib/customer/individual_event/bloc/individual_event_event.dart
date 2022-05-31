part of 'individual_event_bloc.dart';

abstract class IndividualEventEvent extends Equatable {
  const IndividualEventEvent();

  @override
  List<Object> get props => [];
}

class LoadIndividualEvent extends IndividualEventEvent {}
