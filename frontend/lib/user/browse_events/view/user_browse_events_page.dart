import 'package:flutter/material.dart';

//Tinder like swipe screen with all available restaurant events for the day
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
