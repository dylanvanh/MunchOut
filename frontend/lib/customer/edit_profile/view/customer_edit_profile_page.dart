import 'package:customer_repository/customer_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdma3_mobile_app/customer/edit_profile/edit_profile.dart';
import 'package:user_repository/user_repository.dart';

/// Edit user screen form , allows the user to change their
/// name,password,phonenumber
class UserEditProfilePage extends StatelessWidget {
  const UserEditProfilePage({Key? key}) : super(key: key);

  static MaterialPageRoute<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const UserEditProfilePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Restaurant Add Event Page')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider(
          create: (context) {
            return EditProfileBloc(
              userRepository: RepositoryProvider.of<UserRepository>(context),
              customerRepository:
                  RepositoryProvider.of<CustomerRepository>(context),
            );
          },
          child: const CustomerEditProfileForm(),
        ),
      ),
    );
  }
}
