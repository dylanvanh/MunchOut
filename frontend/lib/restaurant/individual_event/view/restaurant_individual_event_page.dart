import 'package:flutter/material.dart';

/// List of the different customers booked for it the specific event
class RestaurantIndivudualEventPage extends StatelessWidget {
  const RestaurantIndivudualEventPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
        builder: (_) => const RestaurantIndivudualEventPage());
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
