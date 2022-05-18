import 'package:flutter/material.dart';

/// Displays list of events bookings the user has made for the day
class UserBookingsPage extends StatelessWidget {
  const UserBookingsPage({Key? key}) : super(key: key);

  static MaterialPageRoute<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const UserBookingsPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User bookings page'),
      ),
      body: const Text('User bookings page'),
    );
  }
}
