import 'package:flutter/material.dart';

//Is routed to when the restaurant logs in
class RestaurantHomePage extends StatelessWidget {
  const RestaurantHomePage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => const RestaurantHomePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UserEditProfile Page'),
      ),
      body: const Text('UserEditProfile page'),
    );
  }
}
