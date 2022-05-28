import 'dart:async';
import 'dart:convert';

import 'package:customer_repository/customer_repository.dart';
import 'package:flask_api/flask_api.dart';

/// Thrown when [updateUserDetails] encounters an error
class UpdateCustomerDetailsException implements Exception {}

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
}
