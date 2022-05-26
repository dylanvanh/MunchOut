import 'package:flutter/material.dart';
import 'package:itdma3_mobile_app/customer/login/login.dart';
import 'package:itdma3_mobile_app/customer/signup/signup.dart';
import 'package:itdma3_mobile_app/restaurant/login/login.dart';
import 'package:itdma3_mobile_app/restaurant/signup/signup.dart';

///first page shown when the user launches the app
/// Routes to login/signup
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
              child: const Text('Customer Login'),
              onPressed: () => Navigator.of(context).push(
                CustomerLoginPage.route(),
              ),
            ),
            ElevatedButton(
              child: const Text('Customer Sign Up'),
              onPressed: () => Navigator.of(context).push(
                CustomerSignupPage.route(),
              ),
            ),
            ElevatedButton(
              child: const Text('Restaurant Login'),
              onPressed: () => Navigator.of(context).push(
                RestaurantLoginPage.route(),
              ),
            ),
            ElevatedButton(
              child: const Text('Restaurant Sign Up'),
              onPressed: () => Navigator.of(context).push(
                RestaurantSignupPage.route(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
