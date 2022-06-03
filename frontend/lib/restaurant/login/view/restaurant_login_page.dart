import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdma3_mobile_app/restaurant/login/login.dart';
import 'package:user_repository/user_repository.dart';

import '../../signup/signup.dart';

class RestaurantLoginPage extends StatelessWidget {
  RestaurantLoginPage({Key? key}) : super(key: key);

  static Route<RestaurantLoginPage> route() {
    return MaterialPageRoute(
      builder: (context) => RestaurantLoginPage(),
    );
  }

  final Color logoBackground = const Color.fromRGBO(208, 208, 208, 100);
  final Color textColor = const Color.fromRGBO(27, 92, 151, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 20,
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                ),
              ),
            ],
          ),
          // SizedBox(
          //   height: MediaQuery.of(context).size.height / 6,
          // ),
          Container(
            width: MediaQuery.of(context).size.height / 4,
            decoration: BoxDecoration(
              color: logoBackground,
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  100,
                ),
              ),
            ),
            child: Image.asset('assets/logo.png'),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 15,
          ),
          Text(
            'Restaurant Login',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: BlocProvider(
              create: (context) {
                return LoginBloc(
                  userRepository:
                      RepositoryProvider.of<UserRepository>(context),
                );
              },
              child: const RestaurantLoginForm(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    RestaurantSignupPage.route(),
                  );
                },
                child: Row(
                  children: const [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      ' Register Here',
                      style: TextStyle(color: Color.fromARGB(171, 73, 10, 209)),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
