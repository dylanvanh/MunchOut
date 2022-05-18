import 'package:flutter/material.dart';

class UserBrowseEvents extends StatelessWidget {
  const UserBrowseEvents({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const UserBrowseEvents());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UserBrowseEventsPage'),
      ),
      body: const Text('UserBrowseEventsPage'),
    );
  }
}
