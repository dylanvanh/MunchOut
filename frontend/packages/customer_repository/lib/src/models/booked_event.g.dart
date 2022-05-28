// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booked_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookedEvent _$BookedEventFromJson(Map<String, dynamic> json) => BookedEvent(
      event_id: json['event_id'] as int?,
      name: json['name'] as String?,
      date: json['date'] as String?,
      booking_id: json['booking_id'] as int?,
      numAttendees: json['numAttendees'] as int?,
      event_image_url: json['event_image_url'] as String?,
      restaurant_image_url: json['restaurant_image_url'] as String?,
      restaurantName: json['restaurantName'] as String?,
    );

Map<String, dynamic> _$BookedEventToJson(BookedEvent instance) =>
    <String, dynamic>{
      'event_id': instance.event_id,
      'name': instance.name,
      'date': instance.date,
      'booking_id': instance.booking_id,
      'numAttendees': instance.numAttendees,
      'event_image_url': instance.event_image_url,
      'restaurant_image_url': instance.restaurant_image_url,
      'restaurantName': instance.restaurantName,
    };
