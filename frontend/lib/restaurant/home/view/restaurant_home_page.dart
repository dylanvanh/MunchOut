import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdma3_mobile_app/authentication/authentication.dart';
import 'package:itdma3_mobile_app/restaurant/add_event/add_event.dart';
import 'package:itdma3_mobile_app/restaurant/edit_profile/view/restaurant_edit_profile_page.dart';
import 'package:itdma3_mobile_app/restaurant/restaurant_events/restaurant_events.dart';
import 'package:restaurant_repository/restaurant_repository.dart';

//Is routed to when the restaurant logs in

class RestaurantHomePage extends StatelessWidget {
  RestaurantHomePage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => RestaurantHomePage(),
    );
  }

  /// Instantiates restaurantRepository once a restaurant user has logged in
  final restaurantRepository = RestaurantRepository();

  @override
  Widget build(BuildContext context) {
    return RestaurantHomeView();
    // return RepositoryProvider.value(
    //   value: restaurantRepository,
    //   child: RestaurantHomeView(),
    // );
  }
}

class RestaurantHomeView extends StatelessWidget {
  const RestaurantHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Provides all restaurant screens access to the restaurantRepository
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
                  Text(
                    'Welcome restaurant user ${state.validatedUser.name}',
                  ),
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
                      RestaurantEventsPage.route(),
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
