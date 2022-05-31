import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdma3_mobile_app/customer/login/login.dart';
import 'package:itdma3_mobile_app/customer/signup/signup.dart';
import 'package:user_repository/user_repository.dart';

class CustomerSignupPage extends StatelessWidget {
  const CustomerSignupPage({Key? key}) : super(key: key);

  static Route<CustomerSignupPage> route() {
    return MaterialPageRoute(
      builder: (context) => const CustomerSignupPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Sign Up'),
        backgroundColor: Colors.black,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            'assets/restaurant.jpg',
            fit: BoxFit.cover,
            color: Colors.black.withOpacity(0.7),
            colorBlendMode: BlendMode.darken,
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: BlocProvider(
              create: (context) {
                return SignupBloc(
                  userRepository:
                      RepositoryProvider.of<UserRepository>(context),
                );
              },
              child: const CustomerSignupForm(),
            ),
          ),
        ],
      ),
    );
  }
}
