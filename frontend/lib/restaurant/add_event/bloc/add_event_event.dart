part of 'add_event_bloc.dart';

abstract class AddEventEvent extends Equatable {
  const AddEventEvent();

  @override
  List<Object> get props => [];
}

class AddEventNameChanged extends AddEventEvent {
  const AddEventNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class AddEventDescriptionChanged extends AddEventEvent {
  const AddEventDescriptionChanged(this.description);

  final String description;

  @override
  List<Object> get props => [description];
}

class AddEventImageUrlChanged extends AddEventEvent {
  const AddEventImageUrlChanged(this.imageUrl);

  final String imageUrl;

  @override
  List<Object> get props => [imageUrl];
}

class AddEventSubmitted extends AddEventEvent {
  const AddEventSubmitted();
}
