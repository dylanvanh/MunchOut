import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdma3_mobile_app/authentication/authentication.dart';

class RestaurantHomePage extends StatelessWidget {
  const RestaurantHomePage({Key? key}) : super(key: key);

  static Route<RestaurantHomePage> route() {
    return MaterialPageRoute(
      builder: (context) => const RestaurantHomePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthorisedState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Welcome ${state.validatedUser.username}'),
                  ElevatedButton(
                    child: const Text('Logout'),
                    onPressed: () {
                      context.read<AuthBloc>().add(LogoutEvent());
                    },
                  ),
                ],
              ),
            );
          } else {
            //show an empty container
            return Container();
          }
        },
      ),
    );
  }
}
