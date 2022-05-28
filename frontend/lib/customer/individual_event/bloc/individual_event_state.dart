part of 'individual_event_bloc.dart';

abstract class IndividualEventState extends Equatable {
  const IndividualEventState();

  @override
  List<Object?> get props => [];
}

/// State while list of events are been fetched
class IndividualEventLoading extends IndividualEventState {}

/// State when list of events succesfully fetched
class IndividualEventLoaded extends IndividualEventState {
  const IndividualEventLoaded(this.eventDetails, this.restaurantDetails);

  //events that are active for the current day for the restaurant
  final Event? eventDetails;
  final Restaurant? restaurantDetails;

  @override
  List<Object?> get props => [eventDetails, restaurantDetails];
}

/// State when error encountered during fetching of events
class IndividualEventErrorEncountered extends IndividualEventState {}
