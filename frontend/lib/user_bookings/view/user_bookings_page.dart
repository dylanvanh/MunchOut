import 'package:flutter/material.dart';

class UserBookingsPage extends StatelessWidget {
  const UserBookingsPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const UserBookingsPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UserBookings Page'),
      ),
      body: const Text('UserBookings page'),
    );
  }
}
