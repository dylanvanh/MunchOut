import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'restaurant.g.dart';

/// User model
@JsonSerializable()
class Restaurant extends Equatable {
  ///Restaurant contructor
  const Restaurant({
    this.id,
    this.name,
    this.description,
    this.image_url,
    this.phone_number,
  });

  // id of the restaurant
  final int? id;

  // name of the restaurant
  final String? name;

  // // username of the restaurant
  // final String? username;

  // description of the restaurant
  final String? description;

  // imageUrl of the restaurant
  final String? image_url;

  // phoneNumber of the restaurant
  final String? phone_number;

  @override
  List<Object?> get props => [
        id,
        name,
        // username,
        description,
        image_url,
        phone_number,
      ];

  @override
  String toString() {
    return '''
      Restaurant user details : 
      $id, $name, $description,
      $image_url, $phone_number
      ''';
  }

  /// Connect the generated [_$RestaurantFromJson] function to the `fromJson`
  /// factory.
  factory Restaurant.fromJson(Map<String, dynamic> json) =>
      _$RestaurantFromJson(json);

  /// Connect the generated [_$RestaurantToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$RestaurantToJson(this);
}
