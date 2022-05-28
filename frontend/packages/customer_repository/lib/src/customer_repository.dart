import 'dart:async';
import 'dart:convert';

import 'package:customer_repository/customer_repository.dart';
import 'package:flask_api/flask_api.dart';

/// Thrown when [updateUserDetails] encounters an error
class UpdateCustomerDetailsException implements Exception {}

/// Thrown when [getBookings] encounters an error
class FetchBookedEventDetailsException implements Exception {}

class CustomerRepository {
  /// {@macro restaurant_repository}
  CustomerRepository({
    FlaskApi? flaskApi,
  }) : _flaskApi = flaskApi ?? FlaskApi();

  final FlaskApi _flaskApi;

  /// Returns updated restaurant object
  ///
  /// Throws a [UpdateCustomerDetailsException] if an error occurs
  Future<Customer> updateUserDetails({
    required int customerId,
    required String name,
    required String password,
    required String phoneNumber,
  }) async {
    try {
      final response = await _flaskApi.updateCustomerDetails(
        customerId: customerId,
        name: name,
        password: password,
        phoneNumber: phoneNumber,
      );

      final decodedResponse = jsonDecode(response) as Map<String, dynamic>;

      return Customer.fromJson(decodedResponse);
    } on Exception {
      throw UpdateCustomerDetailsException();
    }
  }

  /// Returns a list of event objects
  ///
  /// Throws a [FetchBookedEventDetailsException] if an error occurs
  Future<List<BookedEvent>> getBookings({
    required int customerId,
  }) async {
    try {
      final response = await _flaskApi.fetchCustomerBookings(
        customerId: customerId,
      );

      final decodedResponse = jsonDecode(response)['customerEvents'] as List;

      //convert to list of events
      final bookedEventsList = decodedResponse
          .map(
            (dynamic bookedEvent) =>
                BookedEvent.fromJson(bookedEvent as Map<String, dynamic>),
          )
          .toList();

      return bookedEventsList;
    } on Exception {
      throw FetchBookedEventDetailsException();
    }
  }
}
