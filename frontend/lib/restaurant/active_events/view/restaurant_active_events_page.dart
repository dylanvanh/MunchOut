import 'package:flutter/material.dart';

/// List of all active restaurant events for the day
/// On event tap -> route to individual event page
class RestaurantActiveEventsPage extends StatelessWidget {
  const RestaurantActiveEventsPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => const RestaurantActiveEventsPage(),
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
