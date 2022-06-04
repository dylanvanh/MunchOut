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
            'Confirm number of attendees',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 20,
          ),
          _NumAttendeesInput(),
          const SizedBox(
            height: 10,
          ),
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
            contentPadding: const EdgeInsets.all(8),
            isDense: true,
            labelText: 'Number of Attendees',
            errorText: state.numAttendees.invalid ? 'invalid number' : null,
            prefixIcon: const Icon(Icons.people_alt_rounded),
          ),
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  final Color gradientTopLeft = const Color.fromRGBO(62, 55, 96, 1);
  final Color gradientBottomRight = const Color.fromRGBO(22, 98, 157, 1);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DialogFormBloc, DialogFormState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      gradientTopLeft,
                      gradientBottomRight,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2.5,
                  height: MediaQuery.of(context).size.height / 15,
                  child: ElevatedButton(
                    key: const Key('RestaurantLoginForm_continue_raisedButton'),
                    onPressed: state.status.isValidated
                        ? () {
                            context
                                .read<DialogFormBloc>()
                                .add(const DialogFormSubmitted());
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      onSurface: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(
                        top: 18,
                        bottom: 18,
                      ),
                      child: Text('Create Booking'),
                    ),
                  ),
                ),
              );
      },
    );
  }
}
