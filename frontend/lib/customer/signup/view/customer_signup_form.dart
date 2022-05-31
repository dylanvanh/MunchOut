import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:itdma3_mobile_app/customer/signup/signup.dart';

class CustomerSignupForm extends StatelessWidget {
  const CustomerSignupForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Username already exists')),
            );
        }
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Container(
              width: 450,
              height: 400,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                border: Border.all(
                  color: Colors.black,
                  width: 5,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _NameInput(),
                  _UsernameInput(),
                  _PasswordInput(),
                  _PhoneNumberInput(),
                  const SizedBox(
                    height: 40,
                  ),
                  _SignupButton(),
                ],
              ),
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
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return TextField(
          key: const Key('CustomerSignupForm_nameInput_textField'),
          onChanged: (name) =>
              context.read<SignupBloc>().add(SignupNameChanged(name)),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(12), isDense: true,
            labelText: 'Name',
            errorText: state.name.invalid ? 'Invalid Name' : null,
          ),
        );
      },
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextField(
          key: const Key('CustomerSignupForm_usernameInput_textField'),
          onChanged: (username) =>
              context.read<SignupBloc>().add(SignupUsernameChanged(username)),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(12), isDense: true,
            labelText: 'Username',
            errorText: state.username.invalid ? 'invalid username' : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('CustomerSignupForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<SignupBloc>().add(SignupPasswordChanged(password)),
          obscureText: true,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(12), isDense: true,
            labelText: 'Password',
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
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) =>
          previous.phoneNumber != current.phoneNumber,
      builder: (context, state) {
        return TextField(
          key: const Key('CustomerSignupForm_phoneNumberInput_textField'),
          onChanged: (phoneNumber) => context
              .read<SignupBloc>()
              .add(SignupPhoneNumberChanged(phoneNumber)),
          obscureText: true,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(12), isDense: true,
            labelText: 'Phone Number',
            errorText: state.phoneNumber.invalid ? 'invalid phoneNumber' : null,
          ),
        );
      },
    );
  }
}

class _SignupButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  minimumSize: const Size(140, 50),
                  maximumSize: const Size(140, 50),
                ),
                key: const Key('CustomerSignupForm_continue_raisedButton'),
                onPressed: state.status.isValidated
                    ? () {
                        context.read<SignupBloc>().add(const SignupSubmitted());
                      }
                    : null,
                child: const Text('Signup'),
              );
      },
    );
  }
}
