import 'dart:async';
import 'dart:convert';

import 'package:flask_api/flask_api.dart';
import 'package:restaurant_repository/restaurant_repository.dart';

/// Thrown when [addEvent] encounters an error
class AddEventException implements Exception {}

// Thrown when [getUserDetails] encounters an error
class FetchRestaurantDetailsException implements Exception {}

/// Thrown when [RestaurantDetails] encounters an error
class UpdateRestaurantDetailsException implements Exception {}

/// Thrown when [getActiveEvents] encounters an error
class FetchRestaurantActiveEventsException implements Exception {}

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
  /// Throws a [FetchRestaurantDetailsException] if an error occurs
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

  /// Returns a list of event objects
  ///
  /// Throws a [FetchRestaurantActiveEventsException] if an error occurs
  Future<List<Event>> getActiveEvents({
    required int restaurantId,
  }) async {
    try {
      final response = await _flaskApi.fetchRestaurantActiveEvents(
        restaurantId: restaurantId,
      );

      final decodedResponse = jsonDecode(response)['restaurantEvents'] as List;

      //convert to list of events
      final listEvents = decodedResponse
          .map(
            (dynamic event) => Event.fromJson(event as Map<String, dynamic>),
          )
          .toList();

      return listEvents;
    } on Exception {
      throw FetchRestaurantActiveEventsException();
    }
  }
}

Future<void> main() async {
  final _restaurantRepository = RestaurantRepository();

  //getActiveEvents

  final restaurantEventsList =
      await _restaurantRepository.getActiveEvents(restaurantId: 2);

  for (final event in restaurantEventsList) {
    print(event.description);
  }

  /// // getRestaurantUserDetails
  // final restaurantDetailsObject =
  //     await _restaurantRepository.getUserDetails(restaurantId: 5);
  // print(restaurantDetailsObject.name);
}
