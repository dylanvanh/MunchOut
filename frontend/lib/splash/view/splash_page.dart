import 'package:flutter/material.dart';

//splashPage exposes a static Route which makes it very easy
//to navigate to via Navigator.of(context).push(SplashPage.route())
class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SplashPage());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
