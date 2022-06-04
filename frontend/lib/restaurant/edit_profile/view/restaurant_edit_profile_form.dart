import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:itdma3_mobile_app/restaurant/edit_profile/edit_profile.dart';

class RestaurantEditProfileForm extends StatelessWidget {
  const RestaurantEditProfileForm({Key? key}) : super(key: key);

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
                  'Restaurant details successfully updated',
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
                _DescriptionInput(),
                _ImageUrlInput(),
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
          key: const Key('RestaurantEditProfileForm_nameInput_textField'),
          onChanged: (name) =>
              context.read<EditProfileBloc>().add(EditProfileNameChanged(name)),
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

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('RestaurantEditProfileForm_passwordInput_textField'),
          onChanged: (password) => context
              .read<EditProfileBloc>()
              .add(EditProfilePasswordChanged(password)),
          obscureText: true,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(12),
            isDense: true,
            labelText: 'Password',
            errorText: state.password.invalid ? 'invalid password' : null,
            prefixIcon: const Icon(Icons.key),
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
          key:
              const Key('RestaurantEditProfileForm_phoneNumberInput_textField'),
          onChanged: (phoneNumber) => context
              .read<EditProfileBloc>()
              .add(EditProfilePhoneNumberChanged(phoneNumber)),
          obscureText: true,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10),
            isDense: true,
            labelText: 'Phone Number',
            errorText: state.phoneNumber.invalid ? 'invalid phoneNumber' : null,
            prefixIcon: const Icon(Icons.phone),
          ),
        );
      },
    );
  }
}

class _DescriptionInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      buildWhen: (previous, current) =>
          previous.description != current.description,
      builder: (context, state) {
        return TextField(
          key:
              const Key('RestaurantEditProfileForm_descriptionInput_textField'),
          onChanged: (description) => context
              .read<EditProfileBloc>()
              .add(EditProfileDescriptionChanged(description)),
          obscureText: true,
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
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      buildWhen: (previous, current) => previous.imageUrl != current.imageUrl,
      builder: (context, state) {
        return TextField(
          key: const Key('RestaurantEditProfileForm_imageUrlInput_textField'),
          onChanged: (imageUrl) => context
              .read<EditProfileBloc>()
              .add(EditProfileImageUrlChanged(imageUrl)),
          obscureText: true,
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

class _UpdateDetailsButton extends StatelessWidget {
  final Color gradientTopLeft = const Color.fromRGBO(62, 55, 96, 1);
  final Color gradientBottomRight = const Color.fromRGBO(22, 98, 157, 1);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
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
                        'RestaurantEditProfileForm_continue_raisedButton'),
                    onPressed: state.status.isValidated
                        ? () {
                            context
                                .read<EditProfileBloc>()
                                .add(const EditProfileSubmitted());
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
                      child: Text('Sign Up'),
                    ),
                  ),
                ),
              );
      },
    );
  }
}
