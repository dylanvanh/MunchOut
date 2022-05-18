import 'package:json_annotation/json_annotation.dart';

part 'jwt.g.dart';

/// Model containing the JWT token
/// (required for authentication to different end points)
/// A successfull JWT received indicates valid username&login details for a user
@JsonSerializable()
class Jwt {
  /// Constructor
  const Jwt({required this.accessToken});

  /// Converts a JSON [Map] into a [Jwt] instance
  factory Jwt.fromJson(Map<String, dynamic> json) => _$JwtFromJson(json);

  /// Converts [Jwt] instance into a JSON [Map]
  Map<String, dynamic> toJson() => _$JwtToJson(this);

  /// contains the token key returned
  final String accessToken;

  //prints out the
  @override
  String toString() {
    return 'JWT token = [$accessToken]';
  }
}
