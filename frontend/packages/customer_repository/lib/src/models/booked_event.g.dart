// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booked_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookedEvent _$BookedEventFromJson(Map<String, dynamic> json) => BookedEvent(
      event_id: json['event_id'] as int?,
      event_name: json['event_name'] as String?,
      event_description: json['event_description'] as String?,
      event_date: json['event_date'] as String?,
      event_image_url: json['event_image_url'] as String?,
      booking_id: json['booking_id'] as int?,
      booking_num_attendees: json['booking_num_attendees'] as int?,
      restaurant_id: json['restaurant_id'] as int?,
      restaurant_name: json['restaurant_name'] as String?,
      restaurant_description: json['restaurant_description'] as String?,
      restaurant_image_url: json['restaurant_image_url'] as String?,
      restaurant_phone_number: json['restaurant_phone_number'] as String?,
    );

Map<String, dynamic> _$BookedEventToJson(BookedEvent instance) =>
    <String, dynamic>{
      'event_id': instance.event_id,
      'event_name': instance.event_name,
      'event_description': instance.event_description,
      'event_date': instance.event_date,
      'event_image_url': instance.event_image_url,
      'booking_id': instance.booking_id,
      'booking_num_attendees': instance.booking_num_attendees,
      'restaurant_id': instance.restaurant_id,
      'restaurant_name': instance.restaurant_name,
      'restaurant_description': instance.restaurant_description,
      'restaurant_image_url': instance.restaurant_image_url,
      'restaurant_phone_number': instance.restaurant_phone_number,
    };
