part of 'dialog_form_bloc.dart';

class DialogFormState extends Equatable {
  const DialogFormState({
    this.status = FormzStatus.pure,
    this.numAttendees = const NumAttendees.pure(),
  });

  final FormzStatus status;
  final NumAttendees numAttendees;

  DialogFormState copyWith({
    FormzStatus? status,
    NumAttendees? numAttendees,
  }) {
    return DialogFormState(
      status: status ?? this.status,
      numAttendees: numAttendees ?? this.numAttendees,
    );
  }

  @override
  List<Object> get props => [status, numAttendees];
}
