import 'dart:convert';

import 'package:flask_api/flask_api.dart';
import 'package:http/http.dart' as http;

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

  // http://192.168.1.160:5000/auth -> full url example
  // using ipv4 address as localhost(127.0.0.1) doesnt work with emulator
  static const _baseUrl = '192.168.1.160:5000';

  final http.Client _httpClient;

  /// Requests auth token for user with provided details
  /// if user details correct -> returns auth token
  Future<Jwt> requestAuthToken(String username, String password) async {
    final uri = Uri.http(_baseUrl, 'auth');

    final jwtResponse = await _httpClient.post(
      uri,
      headers: <String, String>{'Content-Type': 'application/json'},
      body: json.encode(
        <String, String>{
          'username': username,
          'password': password,
        },
      ),
    );

    if (jwtResponse.statusCode != 200) {
      throw HttpRequestFailure(jwtResponse.statusCode);
    }

    //invalid username / password provided
    if (jwtResponse.statusCode == 401) {
      throw InvalidCredentialsProvidedFailure();
    }

    final jwtJson = jsonDecode(
      jwtResponse.body,
    ) as Map<String, dynamic>;

    /// converts json-> Jwt instance
    /// returns -> Jwt object
    return Jwt.fromJson(jwtJson);
  }

  /// Request a user to be created in the db
  /// returns
  Future<void> signUpUser(String username, String password) async {
    final uri = Uri.http(_baseUrl, 'register');

    final jwtResponse = await _httpClient.post(
      uri,
      headers: <String, String>{'Content-Type': 'application/json'},
      body: json.encode(
        <String, String>{
          'username': username,
          'password': password,
        },
      ),
    );

    //user already exists
    if (jwtResponse.statusCode == 400) {
      throw SignUpUserException();
    }
  }
}
