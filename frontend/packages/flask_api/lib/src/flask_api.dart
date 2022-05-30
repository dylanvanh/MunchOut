import 'dart:convert';

import 'package:http/http.dart' as http;

/// Thrown if any error regarding the http request
class HttpRequestFailure implements Exception {
  ///constructor
  const HttpRequestFailure(this.statusCode);

  /// Status code of the response
  final int statusCode;
}

/// If the username and password is valid (passed in body) for /auth endpoint
/// -> auth token is returned by the api
class FlaskApi {
  /// FlaskApi constructor
  FlaskApi({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  // http://192.168.1.160:5000/customer_login -> full url example
  // using ipv4 address (192.) as localhost(127.0.0.1) doesnt work with emulator
  static const _baseUrl = '192.168.1.160:5000';

  final http.Client _httpClient;

  /// Helper function for determing success/failure of api calls
  void validateStatusCodes(int statusCode) {
    // Bad request response
    if (statusCode == 400) {
      throw const HttpRequestFailure(400);
    }

    //Unauthorised response
    if (statusCode == 401) {
      throw HttpRequestFailure(statusCode);
    }

    // Object rqeuested doesnt exist
    if (statusCode == 404) {
      throw HttpRequestFailure(statusCode);
    }

    //Internal server error response
    if (statusCode == 500) {
      throw HttpRequestFailure(statusCode);
    }

    // Created succesfully response (201)
    //Ok response (200)

    // If not sucessfully created || provided an Ok response
    if (statusCode != 201 && statusCode != 200) {
      throw HttpRequestFailure(statusCode);
    }
  }

  /// Login api call for a customer user
  /// Returns the restaurant user details
  ///
  /// Throws a [HttpRequestFailure] if an error occurs
  /// or invalid credentials provided
  Future<String> customerLogin(
    String username,
    String password,
  ) async {
    final uri = Uri.http(_baseUrl, 'customer_login');

    final response = await _httpClient.post(
      uri,
      headers: <String, String>{'Content-Type': 'application/json'},
      body: json.encode(
        <String, String>{
          'username': username,
          'password': password,
        },
      ),
    );

    validateStatusCodes(response.statusCode);

    //returns user details map
    return response.body;
  }

  /// Sign up api call for a customer user
  /// Returns the new customer user details
  ///
  /// Throws a [HttpRequestFailure] if an error occurs
  /// or username provided already exists in the db
  Future<String> customerSignup(
    String name,
    String username,
    String password,
    String phoneNumber,
  ) async {
    final uri = Uri.http(_baseUrl, '/customer_signup');

    final response = await _httpClient.post(
      uri,
      headers: <String, String>{'Content-Type': 'application/json'},
      body: json.encode(
        <String, String>{
          'name': name,
          'username': username,
          'password': password,
          'phone_number': phoneNumber,
        },
      ),
    );

    validateStatusCodes(response.statusCode);
    return response.body;
  }

  /// Login api call for a restaur user
  /// Returns the restaurant user details
  ///
  /// Throws a [HttpRequestFailure] if an error occurs
  /// or invalid credentials provided
  Future<String> restaurantLogin(
    String username,
    String password,
  ) async {
    final uri = Uri.http(_baseUrl, 'restaurant_login');

    final response = await _httpClient.post(
      uri,
      headers: <String, String>{'Content-Type': 'application/json'},
      body: json.encode(
        <String, String>{
          'username': username,
          'password': password,
        },
      ),
    );

    validateStatusCodes(response.statusCode);
    return response.body;
  }

  /// Sign up api call for a restaurant user
  /// Returns the new restaurant user details
  ///
  /// Throws a [HttpRequestFailure] if an error occurs
  /// or username provided already exists in the db
  Future<String> restaurantSignup(
    String name,
    String username,
    String password,
    String description,
    String imageurl,
    String phoneNumber,
  ) async {
    final uri = Uri.http(_baseUrl, '/restaurant_signup');

    final response = await _httpClient.post(
      uri,
      headers: <String, String>{'Content-Type': 'application/json'},
      body: json.encode(
        <String, String>{
          'name': name,
          'username': username,
          'password': password,
          'description': description,
          'image_url': imageurl,
          'phone_number': phoneNumber,
        },
      ),
    );

    validateStatusCodes(response.statusCode);
    return response.body;
  }

  /// Returns nothing
  ///
  /// Throws a [HttpRequestFailure] if an error occurs
  Future<void> restaurantAddEvent({
    required int restaurantId,
    required String name,
    required String description,
    required String imageUrl,
  }) async {
    final uri = Uri.http(_baseUrl, '/add_event');

    final response = await _httpClient.post(
      uri,
      headers: <String, String>{'Content-Type': 'application/json'},
      body: json.encode(
        <String, dynamic>{
          'restaurant_id': restaurantId,
          'name': name,
          'description': description,
          'image_url': imageUrl,
        },
      ),
    );

    validateStatusCodes(response.statusCode);
  }

  /// Returns restaurant user details
  ///
  /// Throws a [HttpRequestFailure] if an error occurs
  Future<String> fetchRestaurantUserDetails({
    required int restaurantId,
  }) async {
    final uri = Uri.http(_baseUrl, '/restaurant/$restaurantId');

    final response = await _httpClient.get(uri);

    validateStatusCodes(response.statusCode);

    return response.body;
  }

  /// Returns customer user details
  ///
  /// Throws a [HttpRequestFailure] if an error occurs
  Future<String> fetchCustomerUserDetails({
    required int customerId,
  }) async {
    final uri = Uri.http(_baseUrl, '/customer/$customerId');

    final response = await _httpClient.get(uri);

    validateStatusCodes(response.statusCode);

    return response.body;
  }

  /// Returns updated restaurant user details
  ///
  /// Throws a [HttpRequestFailure] if an error occurs
  Future<String> updateRestaurantDetails({
    required int restaurantId,
    String? name,
    String? password,
    String? phoneNumber,
    String? description,
    String? imageUrl,
  }) async {
    final uri = Uri.http(_baseUrl, '/restaurant/$restaurantId');

    final response = await _httpClient.patch(
      uri,
      headers: <String, String>{'Content-Type': 'application/json'},
      body: json.encode(
        <String, dynamic>{
          'restaurant_id': restaurantId,
          'password': password,
          'name': name,
          'description': description,
          'image_url': imageUrl,
        },
      ),
    );

    validateStatusCodes(response.statusCode);

    return response.body;
  }

  /// Returns a restaurants active events for today
  /// (Active events -> Events that the restaurant created today)
  ///
  /// Throws a [HttpRequestFailure] if an error occurs
  Future<String> fetchRestaurantEvents({
    required int restaurantId,
  }) async {
    final uri = Uri.http(_baseUrl, '/restaurant_events/$restaurantId');

    final response = await _httpClient.get(uri);

    validateStatusCodes(response.statusCode);

    return response.body;
  }

  /// Returns a restaurants active events for today
  /// (Active events -> Events that the restaurant created today)
  ///
  /// Throws a [HttpRequestFailure] if an error occurs
  Future<String> fetchRestaurantEventBookings({
    required int eventId,
  }) async {
    final uri = Uri.http(_baseUrl, '/event_bookings/$eventId');

    final response = await _httpClient.get(uri);

    validateStatusCodes(response.statusCode);

    return response.body;
  }

  /// Returns updated restaurant user details
  ///
  /// Throws a [HttpRequestFailure] if an error occurs
  Future<String> updateCustomerDetails({
    required int customerId,
    String? name,
    String? password,
    String? phoneNumber,
  }) async {
    final uri = Uri.http(_baseUrl, '/customer/$customerId');

    final response = await _httpClient.patch(
      uri,
      headers: <String, String>{'Content-Type': 'application/json'},
      body: json.encode(
        <String, dynamic>{
          'customer_id': customerId,
          'password': password,
          'name': name,
        },
      ),
    );

    validateStatusCodes(response.statusCode);

    return response.body;
  }

  /// Returns bookings,event details for a customer user
  ///
  /// Throws a [HttpRequestFailure] if an error occurs
  Future<String> fetchCustomerBookings({
    required int customerId,
  }) async {
    final uri = Uri.http(_baseUrl, '/customer_booked_events/$customerId');

    final response = await _httpClient.get(uri);

    validateStatusCodes(response.statusCode);

    return response.body;
  }

  /// Returns event details for an individual event
  /// event/<eventId>
  /// Throws a [HttpRequestFailure] if an error occurs
  Future<String> fetchIndividualEventDetails({
    required int eventId,
  }) async {
    final uri = Uri.http(_baseUrl, '/event/$eventId');

    final response = await _httpClient.get(uri);

    validateStatusCodes(response.statusCode);

    return response.body;
  }

  /// Returns event details for an individual event
  /// event/<eventId>
  /// Throws a [HttpRequestFailure] if an error occurs
  Future<String> fetchIndividualRestaurantDetails({
    required int restaurantId,
  }) async {
    final uri = Uri.http(_baseUrl, '/restaurant/$restaurantId');

    final response = await _httpClient.get(uri);

    validateStatusCodes(response.statusCode);

    return response.body;
  }

  /// Returns all available event details for a user
  /// /customer_available_events/<customerId>
  /// Throws a [HttpRequestFailure] if an error occurs
  Future<String> fetchCustomerAvailableEvents({
    required int customerId,
  }) async {
    final uri = Uri.http(_baseUrl, '/customer_available_events/$customerId');

    final response = await _httpClient.get(uri);

    validateStatusCodes(response.statusCode);

    return response.body;
  }

  /// Returns nothing
  ///
  /// Throws a [HttpRequestFailure] if an error occurs
  Future<void> customerCreateBooking({
    required int eventId,
    required int customerId,
    required int numAttendees,
  }) async {
    final uri = Uri.http(_baseUrl, '/add_booking');

    final response = await _httpClient.post(
      uri,
      headers: <String, String>{'Content-Type': 'application/json'},
      body: json.encode(
        <String, int>{
          'event_id': eventId,
          'customer_id': customerId,
          'num_attendees': numAttendees,
        },
      ),
    );

    validateStatusCodes(response.statusCode);
  }
}

// /// FOR TESTING
// Future<void> main() async {
// // //   //instantiate flaskApi repository instance
//   final flaskApi = FlaskApi();

//   try {
//     final response = await flaskApi.fetchCustomerAvailableEvents(customerId: 1);
//     print(response);
//   } on Exception {
//     print('hello');
//   }
// }
// // Fetch event customer bookings for restaurant

//   try {
//     final response = await flaskApi.fetchRestaurantEventBookings(eventId: 1);
//     print(response);
//   } catch (_) {
//     print('error');
//   }

// // Fetch active restaurant events for restaurant
//   try {
//     await flaskApi.fetchRestaurantEvents(restaurantId: 2);
//   } catch (_) {
//     print('error occured');
//   }

//   //update restaurantDetails
//   try {
//     final updatedDetails = await flaskApi.updateRestaurantDetails(
//       restaurantId: 1,
//       name: 'changedName!',
//     );

//     print(updatedDetails);
//   } on Exception {
//     print('error');
//   }

//fetch restaurantDetails
// try {
//   final restaurantDetails =
//       await flaskApi.fetchRestaurantUserDetails(restaurantId: 5);

//   print(restaurantDetails);
// } on Exception {
//   print('error');
// }

//   //add event
//   try {
//     await flaskApi.restaurantAddEvent(
//       restaurantId: 1,
//       name: 'testEvent',
//       description: 'test',
//       imageUrl: 'www.image.com',
//     );
//   } on Exception {
//     //invalid details
//     print("error");
//   }

//   /// LOGIN
//   try {
//     final dynamic userDetails = await flaskApi.restaurantLogin(
//       'dylan',
//       '1234',
//     );
//     print(userDetails);
//   } on Exception {
//     //invalid details
//     print("invalid login details");
//   }

//   /// Signup
//   try {
//     // await flaskApi.restaurantSignup();
//     final dynamic userDetails = await flaskApi.restaurantSignup(
//       'debonairs pizza',
//       'debonairs',
//       '1234',
//       'pizza place!',
//       'www.image.com',
//       '063838483',
//     );
//     print(userDetails);
//   } on Exception {
//     print('error');
//     print('user details already exist');
//   }
// }
