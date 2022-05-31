// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'available_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvailableEvent _$AvailableEventFromJson(Map<String, dynamic> json) =>
    AvailableEvent(
      event_id: json['event_id'] as int?,
      event_name: json['event_name'] as String?,
      event_image_url: json['event_image_url'] as String?,
      event_description: json['event_description'] as String?,
      event_date: json['event_date'] as String?,
      restaurant_id: json['restaurant_id'] as int?,
      restaurant_name: json['restaurant_name'] as String?,
      restaurant_image_url: json['restaurant_image_url'] as String?,
    );

Map<String, dynamic> _$AvailableEventToJson(AvailableEvent instance) =>
    <String, dynamic>{
      'event_id': instance.event_id,
      'event_name': instance.event_name,
      'event_image_url': instance.event_image_url,
      'event_description': instance.event_description,
      'event_date': instance.event_date,
      'restaurant_id': instance.restaurant_id,
      'restaurant_name': instance.restaurant_name,
      'restaurant_image_url': instance.restaurant_image_url,
    };
