import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:itdma3_mobile_app/restaurant/add_event/add_event.dart';

class RestaurantAddEventForm extends StatelessWidget {
  const RestaurantAddEventForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddEventBloc, AddEventState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.of(context).pop();
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
            labelText: 'name',
            errorText: state.name.invalid ? 'Invalid Name' : null,
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
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'description',
            errorText: state.description.invalid ? 'invalid description' : null,
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
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'imageUrl',
            errorText: state.description.invalid ? 'invalid imageUrl' : null,
          ),
        );
      },
    );
  }
}

class _AddEventButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEventBloc, AddEventState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('RestaurantAddEventForm_continue_raisedButton'),
                onPressed: state.status.isValidated
                    ? () {
                        context
                            .read<AddEventBloc>()
                            .add(const AddEventSubmitted());
                      }
                    : null,
                child: const Text('AddEvent'),
              );
      },
    );
  }
}
