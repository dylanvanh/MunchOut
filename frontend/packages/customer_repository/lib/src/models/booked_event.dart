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
    this.name,
    this.date,
    this.booking_id,
    this.numAttendees,
    this.event_image_url,
    this.restaurant_image_url,
    this.restaurantName,
  });

  // id of the event
  final int? event_id;

  // name of the event
  final String? name;

  // date of the booking
  final String? date;

  // imageUrl of the event
  final String? event_image_url;

  // id of the booking
  final int? booking_id;

  // number of people attending
  final int? numAttendees;

  // imageUrl of the restaurant
  final String? restaurant_image_url;

  // name of the restaurant
  final String? restaurantName;

  @override
  List<Object?> get props => [
        event_id,
        name,
        date,
        booking_id,
        numAttendees,
        event_image_url,
        restaurant_image_url,
        restaurantName,
      ];

  @override
  String toString() {
    return '''
      BookedEvent user details : 
      $event_id , $name , $date , $booking_id,
      $numAttendees, $event_image_url, $restaurant_image_url, $restaurantName
      ''';
  }

  /// Connect the generated [_$BookedEventFromJson] function to the `fromJson`
  /// factory.
  factory BookedEvent.fromJson(Map<String, dynamic> json) =>
      _$BookedEventFromJson(json);

  /// Connect the generated [_$BookedEventToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$BookedEventToJson(this);
}
