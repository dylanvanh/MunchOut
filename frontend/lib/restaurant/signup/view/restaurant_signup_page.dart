import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdma3_mobile_app/restaurant/signup/signup.dart';
import 'package:user_repository/user_repository.dart';

class RestaurantSignupPage extends StatelessWidget {
  RestaurantSignupPage({Key? key}) : super(key: key);

  static Route<RestaurantSignupPage> route() {
    return MaterialPageRoute(
      builder: (context) => RestaurantSignupPage(),
    );
  }

  final Color gradientTopLeft = const Color.fromRGBO(62, 55, 96, 1);
  final Color gradientBottomRight = const Color.fromRGBO(22, 98, 157, 1);
  final Color logoBackground = const Color.fromRGBO(208, 208, 208, 100);
  final Color textColor = const Color.fromRGBO(27, 92, 151, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
              height: MediaQuery.of(context).size.height / 25,
            ),
            Text(
              'Restaurant Signup',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: BlocProvider(
                create: (context) {
                  return SignupBloc(
                    userRepository:
                        RepositoryProvider.of<UserRepository>(context),
                  );
                },
                child: const RestaurantSignupForm(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
