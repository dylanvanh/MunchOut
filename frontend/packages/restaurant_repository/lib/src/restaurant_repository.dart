import 'dart:async';
import 'dart:convert';

import 'package:flask_api/flask_api.dart';
import 'package:restaurant_repository/restaurant_repository.dart';

/// Thrown when [addEvent] encounters an error
class AddEventException implements Exception {}

/// Thrown when [getRestaurantDetails] encounters an error
class FetchRestaurantDetailsException implements Exception {}

class RestaurantRepository {
  /// {@macro restaurant_repository}
  RestaurantRepository({FlaskApi? flaskApi})
      : _flaskApi = flaskApi ?? FlaskApi();

  final FlaskApi _flaskApi;

  /// Returns nothing
  ///
  /// Throws a [AddEventException] if an error occurs
  Future<void> addEvent({
    required int restaurantId,
    required String name,
    required String description,
    required String imageUrl,
  }) async {
    try {
      await _flaskApi.restaurantAddEvent(
        restaurantId: restaurantId,
        name: name,
        description: description,
        imageUrl: imageUrl,
      );
    } on Exception {
      throw AddEventException();
    }
  }

  /// Returns restaurant object
  ///
  /// Throws a [AddEventException] if an error occurs
  Future<Restaurant> getUserDetails({
    required int restaurantId,
  }) async {
    try {
      final response = await _flaskApi.fetchRestaurantUserDetails(
        restaurantId: restaurantId,
      );

      final decodedResponse = jsonDecode(response) as Map<String, dynamic>;

      return Restaurant.fromJson(decodedResponse);
    } on Exception {
      throw FetchRestaurantDetailsException();
    }
  }

  /// Returns updated restaurant object
  ///
  /// Throws a [AddEventException] if an error occurs
  Future<Restaurant> updateUserDetails({
    required int restaurantId,
    required String name,
    required String password,
    required String phoneNumber,
    required String description,
    required String imageUrl,
  }) async {
    try {
      final response = await _flaskApi.updateRestaurantDetails(
        restaurantId: restaurantId,
        name: name,
        password: password,
        phoneNumber: phoneNumber,
        description: description,
        imageUrl: imageUrl,
      );

      final decodedResponse = jsonDecode(response) as Map<String, dynamic>;

      return Restaurant.fromJson(decodedResponse);
    } on Exception {
      throw FetchRestaurantDetailsException();
    }
  }

  // Future<void> main() async {
  //   final _restaurantRepository = RestaurantRepository();

  //   // getRestaurantUserDetails
  //   final restaurantDetailsObject =
  //       await _restaurantRepository.getUserDetails(restaurantId: 5);
  //   print(restaurantDetailsObject.name);
  // }
}
