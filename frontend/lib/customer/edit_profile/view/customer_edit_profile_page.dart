import 'package:customer_repository/customer_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdma3_mobile_app/customer/edit_profile/edit_profile.dart';
import 'package:itdma3_mobile_app/customer/navigation_bar/view/customer_nav_bar.dart';
import 'package:user_repository/user_repository.dart';

/// Edit user screen form , allows the user to change their
/// name,password,phonenumber
class CustomerEditProfilePage extends StatelessWidget {
  const CustomerEditProfilePage({Key? key}) : super(key: key);

  static Route<CustomerEditProfilePage> route() {
    return MaterialPageRoute(
      builder: (context) => const CustomerEditProfilePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavBar(test: 0),
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
