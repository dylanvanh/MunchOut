import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'booked_event.g.dart';

/// User model
@JsonSerializable()
class BookedEvent extends Equatable {
  ///User contructor
  ///User auth status intially set to unauthenticated
  const BookedEvent({
    this.event_id,
    this.event_name,
    this.event_description,
    this.event_date,
    this.event_image_url,
    this.booking_id,
    this.booking_num_attendees,
    this.restaurant_id,
    this.restaurant_name,
    this.restaurant_description,
    this.restaurant_image_url,
    this.restaurant_phone_number,
  });

  // id of the event
  final int? event_id;

  // name of the event
  final String? event_name;

  // description of the event
  final String? event_description;

  // date of the booking
  final String? event_date;

  // imageUrl of the event
  final String? event_image_url;

  // id of the booking
  final int? booking_id;

  // number of people attending for the booking
  final int? booking_num_attendees;

  // id of the restaurant
  final int? restaurant_id;

  // name of the restaurant
  final String? restaurant_name;

  // description of the restaurant
  final String? restaurant_description;

  // imageUrl of the restaurant
  final String? restaurant_image_url;

  // phoneNumber of the restaurant
  final String? restaurant_phone_number;

  @override
  List<Object?> get props => [
        event_id,
        event_name,
        event_description,
        event_date,
        event_image_url,
        booking_id,
        booking_num_attendees,
        restaurant_id,
        restaurant_name,
        restaurant_description,
        restaurant_image_url,
        restaurant_phone_number,
      ];

  @override
  String toString() {
    return '''
      BookedEvent user details : 
      $event_id , $event_name , $event_description , $event_date,
      $event_image_url, $booking_id, $booking_num_attendees, $restaurant_id,
      $restaurant_name, $restaurant_description, $restaurant_image_url, 
      $restaurant_phone_number
      ''';
  }

  /// Connect the generated [_$BookedEventFromJson] function to the `fromJson`
  /// factory.
  factory BookedEvent.fromJson(Map<String, dynamic> json) =>
      _$BookedEventFromJson(json);

  /// Connect the generated [_$BookedEventToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$BookedEventToJson(this);
}
