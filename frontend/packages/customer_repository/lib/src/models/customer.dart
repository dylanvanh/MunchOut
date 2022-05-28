import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'customer.g.dart';

/// User model
@JsonSerializable()
class Customer extends Equatable {
  ///User contructor
  ///User auth status intially set to unauthenticated
  const Customer({
    this.id,
    this.name,
    this.username,
    this.phone_number,
  });

  /// customer user id created by flask
  final int? id;

  /// Customer name
  final String? name;

  /// username that is used for signin
  final String? username;

  /// phoneNumber for contact details
  final String? phone_number;

  @override
  List<Object?> get props => [
        id,
        name,
        username,
        phone_number,
      ];

  @override
  String toString() {
    return '''
      Customer user details : $id , $name , $username , $phone_number''';
  }

  /// Connect the generated [_$CustomerFromJson] function to the `fromJson`
  /// factory.
  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);

  /// Connect the generated [_$CustomerToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}
