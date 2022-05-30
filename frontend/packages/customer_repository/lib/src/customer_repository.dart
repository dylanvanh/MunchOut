import 'dart:async';
import 'dart:convert';

import 'package:customer_repository/customer_repository.dart';
import 'package:flask_api/flask_api.dart';

/// Thrown when [updateUserDetails] encounters an error
class UpdateCustomerDetailsException implements Exception {}

/// Thrown when [getBookings] encounters an error
class FetchBookedEventDetailsException implements Exception {}

/// Thrown when [getIndividualEventDetails] encounters an error
class FetchEventDetailsException implements Exception {}

/// Thrown when [getIndividualRestaurantDetails] encounters an error
class FetchRestaurantDetailsException implements Exception {}

/// Thrown when [getAvailableEvents] encounters an error
class FetchAvailableEventDetailsException implements Exception {}

/// Thrown when [createBooking] encounters an error
class CreateBookingForEventException implements Exception {}

class CustomerRepository {
  /// {@macro restaurant_repository}
  CustomerRepository({
    FlaskApi? flaskApi,
    int? currentEventIndex,
    int? numEvents,
  })  : _flaskApi = flaskApi ?? FlaskApi(),
        _currentEventIndex = currentEventIndex ?? 0,
        _numEvents = numEvents ?? 0;
  // set default index for event showing to 0

  final FlaskApi _flaskApi;

  int _currentEventIndex;
  int _numEvents;

  void updateNumEvents(int numEvents) {
    _numEvents = numEvents;
  }

  int getNumEvents() {
    return _numEvents;
  }

  /// returns the _currentEventIndex value
  int getCurrentEventIndex() {
    //returns the current value
    return _currentEventIndex;
  }

  /// increments the eventIndex
  void incrementCurrentEventIndex({required int numEventTotal}) {
    if (numEventTotal >= _currentEventIndex + 1) {
      _currentEventIndex += 1;
    }
  }

  /// resets the event index to 0
  /// shows the first event as list[0]
  void resetCurrentEventIndex() {
    _currentEventIndex = 0;
  }

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

  /// Returns a individual event details
  ///
  /// Throws a [FetchEventDetailsException] if an error occurs
  Future<Event> getIndividualEventDetails({
    required int eventId,
  }) async {
    try {
      final response = await _flaskApi.fetchIndividualEventDetails(
        eventId: eventId,
      );

      final decodedResponse = jsonDecode(response) as Map<String, dynamic>;

      return Event.fromJson(decodedResponse);
    } on Exception {
      throw FetchEventDetailsException();
    }
  }

  /// Returns a list of event objects
  ///
  /// Throws a [FetchRestaurantDetailsException] if an error occurs
  Future<Restaurant> getIndividualRestaurantDetails({
    required int restaurantId,
  }) async {
    try {
      final response = await _flaskApi.fetchIndividualRestaurantDetails(
        restaurantId: restaurantId,
      );

      final decodedResponse = jsonDecode(response) as Map<String, dynamic>;

      return Restaurant.fromJson(decodedResponse);
    } on Exception {
      throw FetchBookedEventDetailsException();
    }
  }

  /// Returns a list of AvailableEvent (events the user hasne booked) objects
  ///
  /// Throws a [FetchBookedEventDetailsException] if an error occurs
  Future<List<AvailableEvent>> getAvailableEvents({
    required int customerId,
  }) async {
    try {
      final response = await _flaskApi.fetchCustomerAvailableEvents(
        customerId: customerId,
      );

      final decodedResponse =
          jsonDecode(response)['customerAvailableEvents'] as List;

      //convert to list of events
      final availableEventsList = decodedResponse
          .map(
            (dynamic availableEvent) =>
                AvailableEvent.fromJson(availableEvent as Map<String, dynamic>),
          )
          .toList();

      return availableEventsList;
    } on Exception {
      throw FetchAvailableEventDetailsException();
    }
  }

  /// Creates a booking for event after numAttendees submitted in AlertDialog
  ///
  /// Throws a [FetchBookedEventDetailsException] if an error occurs
  Future<void> createBooking({
    required int eventId,
    required int customerId,
    required int numAttendees,
  }) async {
    try {
      //return value not used
      await _flaskApi.customerCreateBooking(
        eventId: eventId,
        customerId: customerId,
        numAttendees: numAttendees,
      );
    } on Exception {
      throw CreateBookingForEventException();
    }
  }
}
