import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flaskjwtlogin/login/login.dart';
import 'package:flutter_flaskjwtlogin/signup/view/signup_form.dart';
import 'package:user_repository/user_repository.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key? key}) : super(key: key);

  static Route<SignupPage> route() {
    return MaterialPageRoute(
      builder: (context) => const SignupPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider(
          create: (context) {
            return LoginBloc(
              userRepository: RepositoryProvider.of<UserRepository>(context),
            );
          },
          child: const SignupForm(),
        ),
      ),
    );
  }
}
