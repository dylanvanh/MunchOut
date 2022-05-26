import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdma3_mobile_app/restaurant/add_event/add_event.dart';
import 'package:restaurant_repository/restaurant_repository.dart';
import 'package:user_repository/user_repository.dart';

/// RestaurantAddEvent is routed to when the restaurant
/// clicks on create a new event
class RestaurantAddEventPage extends StatelessWidget {
  const RestaurantAddEventPage({Key? key}) : super(key: key);

  static MaterialPageRoute<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const RestaurantAddEventPage(),
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
            return AddEventBloc(
              userRepository: RepositoryProvider.of<UserRepository>(context),
              restaurantRepository:
                  RepositoryProvider.of<RestaurantRepository>(context),
            );
          },
          child: const RestaurantAddEventForm(),
        ),
      ),
    );
  }
}
