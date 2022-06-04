import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:itdma3_mobile_app/customer/available_events/available_events.dart';
import 'package:itdma3_mobile_app/customer/bookings/bookings.dart';
import 'package:itdma3_mobile_app/customer/edit_profile/view/customer_edit_profile_page.dart';
import 'package:itdma3_mobile_app/customer/navigation_bar/bloc/customer_nav_bar_bloc.dart';
import 'package:itdma3_mobile_app/restaurant/edit_profile/edit_profile.dart';
import 'package:itdma3_mobile_app/restaurant/edit_profile/view/restaurant_edit_profile_form.dart';
import 'package:itdma3_mobile_app/restaurant/restaurant_events/restaurant_events.dart';

class NavBar extends StatelessWidget {
  NavBar({Key? key, required this.navIndex}) : super(key: key);

  final Color themeColor = const Color.fromRGBO(27, 92, 151, 1);
  final int navIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        child: GNav(
          rippleColor: Colors.lightBlue,
          color: Colors.black,
          activeColor: Colors.white,
          tabBackgroundColor: themeColor,
          padding: const EdgeInsets.all(12),
          gap: 20,
          tabs: const [
            GButton(
              icon: Icons.cookie,
              text: 'Created Events',
            ),
            GButton(
              icon: Icons.person_pin_circle_sharp,
              text: 'Bookings',
            ),
          ],
          selectedIndex: navIndex,
          onTabChange: (index) {
            if (index == navIndex) {
              return;
            }

            if (index == 0) {
              Navigator.of(context).pushAndRemoveUntil<void>(
                RestaurantEventsPage.route(),
                (route) => false,
              );
            }
            if (index == 1) {
              Navigator.of(context).pushAndRemoveUntil<void>(
                RestaurantEditProfilePage.route(),
                (route) => false,
              );
            }
          },
        ),
      ),
    );
  }
}
