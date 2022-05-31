import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:itdma3_mobile_app/customer/edit_profile/edit_profile.dart';

class CustomerEditProfileForm extends StatelessWidget {
  const CustomerEditProfileForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditProfileBloc, EditProfileState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          //goes back to homepage after update button pressed
          Navigator.of(context).pop();

          //shows popup on bottom of screen
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text(
                  'Customer details successfully updated',
                ),
              ),
            );
        }

        if (state.status.isSubmissionFailure) {
          //shows popup on bottom of screen
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Error updating details'),
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
                _PasswordInput(),
                _PhoneNumberInput(),
                const SizedBox(
                  height: 40,
                ),
                _UpdateDetailsButton(),
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
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return TextField(
          key: const Key('CustomerEditProfileForm_nameInput_textField'),
          onChanged: (name) =>
              context.read<EditProfileBloc>().add(EditProfileNameChanged(name)),
          decoration: InputDecoration(
            labelText: 'name',
            errorText: state.name.invalid ? 'Invalid Name' : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('CustomerEditProfileForm_passwordInput_textField'),
          onChanged: (password) => context
              .read<EditProfileBloc>()
              .add(EditProfilePasswordChanged(password)),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'password',
            errorText: state.password.invalid ? 'invalid password' : null,
          ),
        );
      },
    );
  }
}

class _PhoneNumberInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      buildWhen: (previous, current) =>
          previous.phoneNumber != current.phoneNumber,
      builder: (context, state) {
        return TextField(
          key: const Key('CustomerEditProfileForm_phoneNumberInput_textField'),
          onChanged: (phoneNumber) => context
              .read<EditProfileBloc>()
              .add(EditProfilePhoneNumberChanged(phoneNumber)),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'phoneNumber',
            errorText: state.password.invalid ? 'invalid phoneNumber' : null,
          ),
        );
      },
    );
  }
}

class _UpdateDetailsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('CustomerEditProfileForm_continue_raisedButton'),
                onPressed: state.status.isValidated
                    ? () {
                        context
                            .read<EditProfileBloc>()
                            .add(const EditProfileSubmitted());
                      }
                    : null,
                child: const Text('Update Profile'),
              );
      },
    );
  }
}
