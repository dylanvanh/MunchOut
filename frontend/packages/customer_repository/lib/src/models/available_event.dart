import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'available_event.g.dart';

/// User model
@JsonSerializable()
class AvailableEvent extends Equatable {
  ///User contructor
  ///User auth status intially set to unauthenticated
  const AvailableEvent({
    this.event_id,
    this.event_name,
    this.event_image_url,
    this.event_description,
    this.event_date,
    this.restaurant_id,
    this.restaurant_name,
    this.restaurant_image_url,
  });

  // id of the event
  final int? event_id;

  // name of the event
  final int? event_name;

  // imageUrl of the event
  final String? event_image_url;

  // description of the event
  final String? event_description;

  // date of the event
  final String? event_date;

  // id of the restaurant
  final String? restaurant_id;

  // name of the restaurant
  final String? restaurant_name;

  // imageUrl of the restaurant
  final String? restaurant_image_url;

  @override
  List<Object?> get props => [
        event_id,
        event_name,
        event_image_url,
        event_description,
        event_date,
        restaurant_id,
        restaurant_name,
        restaurant_image_url,
      ];

  @override
  String toString() {
    return '''
      AvailableEvent user details : 
      $event_id, $event_name ,$event_image_url,
      $event_description, $event_date , $restaurant_id,
      $restaurant_name, $restaurant_image_url
      ''';
  }

  /// Connect the generated [_$AvailableEventFromJson] function to the `fromJson`
  /// factory.
  factory AvailableEvent.fromJson(Map<String, dynamic> json) =>
      _$AvailableEventFromJson(json);

  /// Connect the generated [_$AvailableEventToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$AvailableEventToJson(this);
}
