import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdma3_mobile_app/restaurant/signup/signup.dart';
import 'package:user_repository/user_repository.dart';

class RestaurantSignupPage extends StatelessWidget {
  const RestaurantSignupPage({Key? key}) : super(key: key);

  static Route<RestaurantSignupPage> route() {
    return MaterialPageRoute(
      builder: (context) => const RestaurantSignupPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Restaurant Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider(
          create: (context) {
            return SignupBloc(
              userRepository: RepositoryProvider.of<UserRepository>(context),
            );
          },
          child: const RestaurantSignupForm(),
        ),
      ),
    );
  }
}
