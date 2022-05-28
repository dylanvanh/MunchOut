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

/// Thrown when [getEventBookings] encounters an error
class FetchRestaurantEventBookingsException implements Exception {}

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
  Future<List<Event>> getEvents({
    required int restaurantId,
  }) async {
    try {
      final response = await _flaskApi.fetchRestaurantEvents(
        restaurantId: restaurantId,
      );

      final decodedResponse = jsonDecode(response)['restaurantEvents'] as List;

      //convert to list of events
      final eventList = decodedResponse
          .map(
            (dynamic event) => Event.fromJson(event as Map<String, dynamic>),
          )
          .toList();

      return eventList;
    } on Exception {
      throw FetchRestaurantActiveEventsException();
    }
  }

  /// Returns a list of event customer bookings
  ///
  /// Throws a [FetchRestaurantActiveEventsException] if an error occurs
  Future<List<Booking>> getEventBookings({
    required int eventId,
  }) async {
    try {
      final response = await _flaskApi.fetchRestaurantEventBookings(
        eventId: eventId,
      );

      final decodedResponse = jsonDecode(response)['bookedCustomers'] as List;

      //convert to list of events
      final eventBookingsList = decodedResponse
          .map(
            (dynamic booking) =>
                Booking.fromJson(booking as Map<String, dynamic>),
          )
          .toList();

      return eventBookingsList;
    } on Exception {
      throw FetchRestaurantEventBookingsException();
    }
  }
}

// Future<void> main() async {
  // final _restaurantRepository = RestaurantRepository();

  //getEventBookings
  // final eventBookingsList =
  //     await _restaurantRepository.getEventBookings(eventId: 1);

  // for (final booking in eventBookingsList) {
  //   print(booking);
  // }

  //getActiveEvents
  // final restaurantEventsList =
  //     await _restaurantRepository.getActiveEvents(restaurantId: 2);

  // for (final event in restaurantEventsList) {
  //   print(event.description);
  // }

  /// // getRestaurantUserDetails
  // final restaurantDetailsObject =
  //     await _restaurantRepository.getUserDetails(restaurantId: 5);
  // print(restaurantDetailsObject.name);
// }
