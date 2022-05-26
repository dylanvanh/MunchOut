import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:itdma3_mobile_app/app/app.dart';
import 'package:itdma3_mobile_app/app/app_bloc_observer.dart';
import 'package:restaurant_repository/restaurant_repository.dart';
import 'package:user_repository/user_repository.dart';

void bootstrap() {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  //instantiate userRepository
  final userRepository = UserRepository();
  final restaurantRepository = RestaurantRepository();

  runZonedGuarded(
    () async {
      await BlocOverrides.runZoned(
        () async => runApp(
          App(
            userRepository: userRepository,
            restaurantRepository: restaurantRepository,
          ),
        ),
        blocObserver: AppBlocObserver(),
      );
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
