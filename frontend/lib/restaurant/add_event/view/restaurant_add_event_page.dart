import 'package:flutter/material.dart';

/// RestaurantAddEvent is routed to when the restaurant
/// clicks on create a new event
class RestaurantAddEventPage extends StatelessWidget {
  const RestaurantAddEventPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => const RestaurantAddEventPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RestaurantEditProfile Page'),
      ),
      body: const Text('RestaurantEditProfile page'),
    );
  }
}
