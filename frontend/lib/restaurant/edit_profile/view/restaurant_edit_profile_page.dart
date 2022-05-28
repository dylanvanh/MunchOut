import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdma3_mobile_app/restaurant/edit_profile/edit_profile.dart';
import 'package:itdma3_mobile_app/restaurant/edit_profile/view/restaurant_edit_profile_form.dart';
import 'package:restaurant_repository/restaurant_repository.dart';
import 'package:user_repository/user_repository.dart';

/// Edit Restaurant screen form , allows the Restaurant to change their
/// name,password & phonenumber & imageUrl
class RestaurantEditProfilePage extends StatelessWidget {
  const RestaurantEditProfilePage({Key? key}) : super(key: key);

  static MaterialPageRoute<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const RestaurantEditProfilePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Restaurant Add Event Page')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider(
          create: (context) {
            return EditProfileBloc(
              userRepository: RepositoryProvider.of<UserRepository>(context),
              restaurantRepository:
                  RepositoryProvider.of<RestaurantRepository>(context),
            );
          },
          child: const RestaurantEditProfileForm(),
        ),
      ),
    );
  }
}
