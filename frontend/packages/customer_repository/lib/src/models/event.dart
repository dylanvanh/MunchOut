import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

/// User model
@JsonSerializable()
class Event extends Equatable {
  ///Event contructor
  const Event({
    this.id,
    this.restaurant_id,
    this.name,
    this.description,
    this.image_url,
    this.date,
  });

  // id of the event
  final int? id;

  // id of the restaurant
  final int? restaurant_id;

  // name of the event
  final String? name;

  // description of the event
  final String? description;

  // imageUrl of the event
  final String? image_url;

  final String? date;

  @override
  List<Object?> get props => [
        id,
        restaurant_id,
        name,
        description,
        image_url,
        date,
      ];

  @override
  String toString() {
    return '''
      Event user details : 
      $id, $restaurant_id ,$name,
      $description, $image_url, $date
      ''';
  }

  /// Connect the generated [_$EventFromJson] function to the `fromJson`
  /// factory.
  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  /// Connect the generated [_$EventToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$EventToJson(this);
}
