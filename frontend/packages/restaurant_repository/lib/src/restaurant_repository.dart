import 'dart:async';
import 'dart:convert';

import 'package:flask_api/flask_api.dart';

class AddEventException implements Exception {}

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
}
