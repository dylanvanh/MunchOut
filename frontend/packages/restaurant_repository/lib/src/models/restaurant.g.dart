// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Restaurant _$RestaurantFromJson(Map<String, dynamic> json) => Restaurant(
      id: json['id'] as int?,
      name: json['name'] as String?,
      username: json['username'] as String?,
      phone_number: json['phone_number'] as String?,
      description: json['description'] as String?,
      image_url: json['image_url'] as String?,
    );

Map<String, dynamic> _$RestaurantToJson(Restaurant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'username': instance.username,
      'description': instance.description,
      'image_url': instance.image_url,
      'phone_number': instance.phone_number,
    };
