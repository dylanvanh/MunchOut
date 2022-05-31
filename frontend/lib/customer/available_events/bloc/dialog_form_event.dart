part of 'dialog_form_bloc.dart';

abstract class DialogFormEvent extends Equatable {
  const DialogFormEvent();

  @override
  List<Object> get props => [];
}

class DialogFormNumAttendeesChanged extends DialogFormEvent {
  const DialogFormNumAttendeesChanged(this.numAttendees);

  final String numAttendees;

  @override
  List<Object> get props => [numAttendees];
}

class DialogFormSubmitted extends DialogFormEvent {
  const DialogFormSubmitted();
}
