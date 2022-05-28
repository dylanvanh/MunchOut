// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Booking _$BookingFromJson(Map<String, dynamic> json) => Booking(
      customer_id: json['customer_id'] as int?,
      customer_name: json['customer_name'] as String?,
      phone_number: json['phone_number'] as String?,
      numAttendees: json['numAttendees'] as int?,
    );

Map<String, dynamic> _$BookingToJson(Booking instance) => <String, dynamic>{
      'customer_id': instance.customer_id,
      'customer_name': instance.customer_name,
      'phone_number': instance.phone_number,
      'numAttendees': instance.numAttendees,
    };
