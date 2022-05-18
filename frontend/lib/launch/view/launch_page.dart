import 'package:flutter/material.dart';
import 'package:flutter_flaskjwtlogin/login/view/view.dart';
import 'package:flutter_flaskjwtlogin/signup/view/view.dart';

class LaunchPage extends StatelessWidget {
  const LaunchPage({Key? key}) : super(key: key);

  static Route<LaunchPage> route() {
    return MaterialPageRoute(
      builder: (context) => const LaunchPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Login'),
              onPressed: () => Navigator.of(context).push(
                LoginPage.route(),
              ),
            ),
            ElevatedButton(
              child: const Text('Sign Up'),
              onPressed: () => Navigator.of(context).push(
                SignupPage.route(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
