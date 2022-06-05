import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdma3_mobile_app/restaurant/add_event/add_event.dart';
import 'package:itdma3_mobile_app/restaurant/navigation_bar/restaurant_nav_bar.dart';
import 'package:restaurant_repository/restaurant_repository.dart';
import 'package:user_repository/user_repository.dart';

/// RestaurantAddEvent is routed to when the restaurant
/// clicks on create a new event
class RestaurantAddEventPage extends StatelessWidget {
  const RestaurantAddEventPage({Key? key}) : super(key: key);

  static Route<RestaurantAddEventPage> route() {
    return MaterialPageRoute(
      builder: (_) => RestaurantAddEventPage(),
    );
  }

  final Color logoBackground = const Color.fromRGBO(208, 208, 208, 100);
  final Color textColor = const Color.fromRGBO(27, 92, 151, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavBar(navIndex: 2),
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
              height: MediaQuery.of(context).size.height / 15,
            ),
            Text(
              'Create Event',
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
                  return AddEventBloc(
                    userRepository:
                        RepositoryProvider.of<UserRepository>(context),
                    restaurantRepository:
                        RepositoryProvider.of<RestaurantRepository>(context),
                  );
                },
                child: const RestaurantAddEventForm(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
