import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:itdma3_mobile_app/restaurant/add_event/add_event.dart';
import 'package:itdma3_mobile_app/restaurant/restaurant_events/restaurant_events.dart';

class RestaurantAddEventForm extends StatelessWidget {
  const RestaurantAddEventForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddEventBloc, AddEventState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.of(context).pushAndRemoveUntil<void>(
            RestaurantEventsPage.route(),
            (route) => false,
          );
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text(
                  'Event successfully created',
                ),
              ),
            );
        }

        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text('Event ${state.name.value} already exists'),
              ),
            );
        }
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _NameInput(),
                _DescriptionInput(),
                _ImageUrlInput(),
                const SizedBox(
                  height: 40,
                ),
                _AddEventButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEventBloc, AddEventState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return TextField(
          key: const Key('RestaurantAddEventForm_nameInput_textField'),
          onChanged: (name) =>
              context.read<AddEventBloc>().add(AddEventNameChanged(name)),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(12),
            isDense: true,
            labelText: 'Name',
            errorText: state.name.invalid ? 'Invalid Name' : null,
            prefixIcon: const Icon(Icons.person),
          ),
        );
      },
    );
  }
}

class _DescriptionInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEventBloc, AddEventState>(
      buildWhen: (previous, current) =>
          previous.description != current.description,
      builder: (context, state) {
        return TextField(
          key: const Key('RestaurantAddEventForm_descriptionInput_textField'),
          onChanged: (description) => context
              .read<AddEventBloc>()
              .add(AddEventDescriptionChanged(description)),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10),
            isDense: true,
            labelText: 'Description',
            errorText: state.description.invalid ? 'invalid description' : null,
            prefixIcon: const Icon(Icons.description),
          ),
        );
      },
    );
  }
}

class _ImageUrlInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEventBloc, AddEventState>(
      buildWhen: (previous, current) => previous.imageUrl != current.imageUrl,
      builder: (context, state) {
        return TextField(
          key: const Key('RestaurantAddEventForm_imageUrlInput_textField'),
          onChanged: (imageUrl) => context
              .read<AddEventBloc>()
              .add(AddEventImageUrlChanged(imageUrl)),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10),
            isDense: true,
            labelText: 'ImageUrl',
            errorText: state.description.invalid ? 'invalid imageUrl' : null,
            prefixIcon: const Icon(Icons.image),
          ),
        );
      },
    );
  }
}

class _AddEventButton extends StatelessWidget {
  final Color gradientTopLeft = const Color.fromRGBO(62, 55, 96, 1);
  final Color gradientBottomRight = const Color.fromRGBO(22, 98, 157, 1);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEventBloc, AddEventState>(
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
                  width: MediaQuery.of(context).size.width / 1.3,
                  height: MediaQuery.of(context).size.height / 15,
                  child: ElevatedButton(
                    key: const Key(
                        'RestaurantAddEventForm_continue_raisedButton'),
                    onPressed: state.status.isValidated
                        ? () {
                            context
                                .read<AddEventBloc>()
                                .add(const AddEventSubmitted());
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
                      child: Text('Create Event'),
                    ),
                  ),
                ),
              );
      },
    );
  }
}
