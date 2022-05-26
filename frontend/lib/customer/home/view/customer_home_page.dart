import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdma3_mobile_app/authentication/authentication.dart';
import 'package:itdma3_mobile_app/customer/bookings/view/view.dart';
import 'package:itdma3_mobile_app/customer/browse_events/view/view.dart';
import 'package:itdma3_mobile_app/customer/edit_profile/view/view.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({Key? key}) : super(key: key);

  static Route<UserHomePage> route() {
    return MaterialPageRoute(
      builder: (context) => const UserHomePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Customer HomePage')),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthorisedState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Welcome ${state.validatedUser.username}'),
                  ElevatedButton(
                    child: const Text('Edit User profile'),
                    onPressed: () => Navigator.of(context).push(
                      UserEditProfilePage.route(),
                    ),
                  ),
                  ElevatedButton(
                    child: const Text('Browse Restaurant events'),
                    onPressed: () => Navigator.of(context).push(
                      UserBrowseEventsPage.route(),
                    ),
                  ),
                  ElevatedButton(
                    child: const Text('View bookings'),
                    onPressed: () => Navigator.of(context).push(
                      UserBookingsPage.route(),
                    ),
                  ),
                  ElevatedButton(
                    child: const Text('Logout'),
                    onPressed: () {
                      context.read<AuthBloc>().add(LogoutEvent());
                    },
                  ),
                ],
              ),
            );
          } else {
            //show an empty container
            return Container();
          }
        },
      ),
    );
  }
}
