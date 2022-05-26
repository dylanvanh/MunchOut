import 'package:flutter/material.dart';

/// Edit user screen form , allows the user to change their
/// name,password,phonenumber
class UserEditProfilePage extends StatelessWidget {
  const UserEditProfilePage({Key? key}) : super(key: key);

  static MaterialPageRoute<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const UserEditProfilePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Edit Profile Page'),
      ),
      body: const Text('User Edit Profile page'),
    );
  }
}
