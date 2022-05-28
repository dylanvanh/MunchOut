import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'booking.g.dart';

/// User model
@JsonSerializable()
class Booking extends Equatable {
  ///User contructor
  ///User auth status intially set to unauthenticated
  const Booking({
    this.customer_id,
    this.customer_name,
    this.phone_number,
    this.numAttendees,
  });

  /// customer Id
  final int? customer_id;

  /// Customer name
  final String? customer_name;

  /// phoneNumber for contact details
  final String? phone_number;

  /// number of attendees for the booking
  final int? numAttendees;

  @override
  List<Object?> get props => [
        customer_id,
        customer_name,
        phone_number,
        numAttendees,
      ];

  @override
  String toString() {
    return '''
      Booking details : $customer_id , $customer_name , $numAttendees,
      $phone_number,
      ''';
  }

  /// Connect the generated [_$BookingFromJson] function to the `fromJson`
  /// factory.
  factory Booking.fromJson(Map<String, dynamic> json) =>
      _$BookingFromJson(json);

  /// Connect the generated [_$BookingToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$BookingToJson(this);
}
