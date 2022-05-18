import 'package:flutter/material.dart';

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
