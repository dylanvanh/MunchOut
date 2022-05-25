import 'dart:convert';

import 'package:http/http.dart' as http;

// /// User types
// enum UserType {
//   ///set when customer user type
//   customer,

//   /// set when restaurant user type
//   restaurant,
// }

/// Thrown if http request != 200 status code
class HttpRequestFailure implements Exception {
  ///constructor
  const HttpRequestFailure(this.statusCode);

  /// Status code of the response
  final int statusCode;
}

/// Thrown when no data is returned for the name provided
class InvalidCredentialsProvidedFailure implements Exception {}

/// Thrown when an error occurs during signup
class SignUpUserException implements Exception {}

/// Thrown when error during decoding response
class JsonDecodeException implements Exception {}

/// Thrown when error deserializing the response body
class JsonDeserializationException implements Exception {}

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

  /// Login api call for a customer user
  Future<dynamic> customerLogin(
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

    if (response.statusCode != 200) {
      throw HttpRequestFailure(response.statusCode);
    }

    //invalid username / password provided
    if (response.statusCode == 401) {
      throw InvalidCredentialsProvidedFailure();
    }

    //returns user details map
    return response.body;
  }

  /// Sign up api call for a customer user
  Future<dynamic> customerSignup(
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

    //user already exists
    if (response.statusCode == 400) {
      throw SignUpUserException();
    }

    return response.body;
  }

  /// Login api call for a restaurant user
  Future<dynamic> restaurantLogin(
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

    if (response.statusCode != 200) {
      throw HttpRequestFailure(response.statusCode);
    }

    //invalid username / password provided
    if (response.statusCode == 401) {
      throw InvalidCredentialsProvidedFailure();
    }

    //returns user details map
    return response.body;
  }

  /// Sign up api call for a restaurant user
  Future<dynamic> restaurantSignup(
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

    //user already exists
    if (response.statusCode == 400) {
      throw SignUpUserException();
    }

    return response.body;
  }
}

// /// FOR TESTING
// Future<void> main() async {
//   final flaskApi = FlaskApi();

//   /// LOGIN
//   try {
//     final dynamic userDetails = await flaskApi.customerLogin('dylan', '1234');
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
