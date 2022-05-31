import 'package:customer_repository/customer_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:itdma3_mobile_app/customer/available_events/available_events.dart';
import 'package:user_repository/user_repository.dart';

class ConfirmBookingAlert extends StatelessWidget {
  const ConfirmBookingAlert({
    Key? key,
    required this.eventId,
  }) : super(key: key);

  final int eventId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DialogFormBloc(
            userRepository: RepositoryProvider.of<UserRepository>(context),
            customerRepository:
                RepositoryProvider.of<CustomerRepository>(context),
            eventId: eventId,
          ),
        ),
        BlocProvider(
          create: (context) => AvailableEventsBloc(
            userRepository: RepositoryProvider.of<UserRepository>(context),
            customerRepository:
                RepositoryProvider.of<CustomerRepository>(context),
          ),
        ),
      ],
      child: const AlertView(),
    );
  }
}

class AlertView extends StatelessWidget {
  const AlertView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          const Text(
            'Confirm Number of Attendees',
          ),
          _NumAttendeesInput(),
          _SubmitButton(),
        ],
      ),
    );
  }
}

class _NumAttendeesInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DialogFormBloc, DialogFormState>(
      buildWhen: (previous, current) =>
          previous.numAttendees != current.numAttendees,
      builder: (context, state) {
        return TextField(
          key: const Key('CustomerDialogFormForm_numAttendeesInput_textField'),
          onChanged: (numAttendees) => context
              .read<DialogFormBloc>()
              .add(DialogFormNumAttendeesChanged(numAttendees)),
          decoration: InputDecoration(
            labelText: 'Number of Attendees',
            errorText: state.numAttendees.invalid ? 'invalid number' : null,
          ),
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DialogFormBloc, DialogFormState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('CustomerDialogFormForm_submit_raisedButton'),
                onPressed: state.status.isValidated
                    ? () {
                        context
                            .read<DialogFormBloc>()
                            .add(const DialogFormSubmitted());
                        Navigator.pop(context, BookingStatus.success);
                      }
                    : null,
                child: const Text('Create Booking'),
              );
      },
    );
  }
}
