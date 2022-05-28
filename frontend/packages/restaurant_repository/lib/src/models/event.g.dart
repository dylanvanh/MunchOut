// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      event_id: json['event_id'] as int?,
      restaurant_id: json['restaurant_id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      image_url: json['image_url'] as String?,
      date: json['date'] as String?,
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'event_id': instance.event_id,
      'restaurant_id': instance.restaurant_id,
      'name': instance.name,
      'description': instance.description,
      'image_url': instance.image_url,
      'date': instance.date,
    };
