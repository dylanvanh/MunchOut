import 'package:flutter/material.dart';

class EditUserPage extends StatelessWidget {
  const EditUserPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const EditUserPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EditUser Page'),
      ),
      body: const Text('EditUser page'),
    );
  }
}
