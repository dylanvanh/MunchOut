import 'package:flutter/material.dart';

/// Edit Restaurant screen form , allows the Restaurant to change their
/// name,password & phonenumber & imageUrl
class RestaurantEditProfilePage extends StatelessWidget {
  const RestaurantEditProfilePage({Key? key}) : super(key: key);

  static MaterialPageRoute<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const RestaurantEditProfilePage(),
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
