import 'package:flutter/material.dart';

/// displays a list of all restaurant
/// events bookings the user has made for the day
class UserAvailableEventsPage extends StatelessWidget {
  const UserAvailableEventsPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
        builder: (_) => const UserAvailableEventsPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UserAvailableEventsPage'),
      ),
      body: const Text('UserAvailableEventsPage'),
    );
  }
}
