import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdma3_mobile_app/authentication/authentication.dart';
import 'package:itdma3_mobile_app/restaurant/active_events/active_events.dart';
import 'package:itdma3_mobile_app/restaurant/add_event/add_event.dart';
import 'package:itdma3_mobile_app/restaurant/edit_profile/view/restaurant_edit_profile.dart';

//Is routed to when the restaurant logs in
class RestaurantHomePage extends StatelessWidget {
  const RestaurantHomePage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => const RestaurantHomePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant HomePage'),
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthorisedState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Welcome restaurant user'),
                  ElevatedButton(
                    child: const Text('Add event'),
                    onPressed: () => Navigator.of(context).push(
                      RestaurantAddEventPage.route(),
                    ),
                  ),
                  ElevatedButton(
                    child: const Text('Edit Profile'),
                    onPressed: () => Navigator.of(context).push(
                      RestaurantEditProfilePage.route(),
                    ),
                  ),
                  ElevatedButton(
                    child: const Text('View your events'),
                    onPressed: () => Navigator.of(context).push(
                      RestaurantActiveEventsPage.route(),
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
            return Container();
          }
        },
      ),
    );
  }
}
