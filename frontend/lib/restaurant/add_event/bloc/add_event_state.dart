part of 'add_event_bloc.dart';

class AddEventState extends Equatable {
  const AddEventState({
    this.status = FormzStatus.pure,
    this.name = const Name.pure(),
    this.description = const Description.pure(),
    this.imageUrl = const ImageUrl.pure(),
  });

  final FormzStatus status;
  final Name name;
  final Description description;
  final ImageUrl imageUrl;

  AddEventState copyWith({
    FormzStatus? status,
    Name? name,
    Description? description,
    ImageUrl? imageUrl,
  }) {
    return AddEventState(
      status: status ?? this.status,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  List<Object> get props => [status, name, description, imageUrl];
}
