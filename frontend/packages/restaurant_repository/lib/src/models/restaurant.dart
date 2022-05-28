import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'restaurant.g.dart';

/// User model
@JsonSerializable()
class Restaurant extends Equatable {
  ///User contructor
  ///User auth status intially set to unauthenticated
  const Restaurant({
    this.id,
    this.name,
    this.username,
    this.phone_number,
    this.description,
    this.image_url, // only gets a value if type =  restaurant user
    // only gets a value if type =  restaurant user
  });

  /// user id created by flask
  final int? id;

  /// Customer Full name / Restaurant name
  final String? name;

  /// username that is used for signin
  final String? username;

  /// short description of the restuarant
  final String? description;

  /// image url of the restaurant for display
  final String? image_url;

  /// phoneNumber for contact details
  final String? phone_number;

  @override
  List<Object?> get props => [
        id,
        name,
        username,
        phone_number,
        description,
        image_url,
      ];

  @override
  String toString() {
    return '''
      Restaurant user details : $id , $name , $username , $phone_number,
      $description , $image_url,
      ''';
  }

  /// Connect the generated [_$RestaurantFromJson] function to the `fromJson`
  /// factory.
  factory Restaurant.fromJson(Map<String, dynamic> json) =>
      _$RestaurantFromJson(json);

  /// Connect the generated [_$RestaurantToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$RestaurantToJson(this);
}
