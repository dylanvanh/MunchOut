import 'package:flutter/material.dart';

//Tinder like swipe screen with all available restaurant events for the day
class AvailableEventsPage extends StatelessWidget {
  const AvailableEventsPage({Key? key}) : super(key: key);

  static MaterialPageRoute<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const AvailableEventsPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User browse events page'),
      ),
      body: const Text('User browse events page'),
    );
  }
}
