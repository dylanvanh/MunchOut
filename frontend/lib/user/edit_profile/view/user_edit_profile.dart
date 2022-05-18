import 'package:flutter/material.dart';

/// Edit user screen form , allows the user to change their
/// name,password,phonenumber
class UserEditProfilePage extends StatelessWidget {
  const UserEditProfilePage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => const UserEditProfilePage(),
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
