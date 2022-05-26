import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

///status options of the user
enum AuthenticationStatus {
  /// set when the user is unathenticated (not logged in)
  unauthenticated,

  /// set when the user is authenticated (logged in)
  authenticated,
}

/// User types that are possible for a logged in user
enum UserType {
  ///set when customer user type
  customer,

  /// set when restaurant user type
  restaurant,
}

/// User model
@JsonSerializable()
class User extends Equatable {
  ///User contructor
  ///User auth status intially set to unauthenticated
  const User({
    this.id,
    this.name,
    this.username,
    this.phoneNumber,
    this.restaurantImageUrl, // only gets a value if type =  restaurant user
    this.restaurantDescription, // only gets a value if type =  restaurant user
    this.userType,
    this.authStatus = AuthenticationStatus.unauthenticated,
  });

  /// user id created by flask
  final int? id;

  /// Customer Full name / Restaurant name
  final String? name;

  /// username that is used for signin
  final String? username;

  /// phoneNumber for contact details
  final String? phoneNumber;

  /// image url of the restaurant for display
  final String? restaurantImageUrl;

  /// short description of the restuarant
  final String? restaurantDescription;

  /// Type of user (either customer / restaurant)
  final UserType? userType;

  ///Authentication status of the user
  final AuthenticationStatus authStatus;

  @override
  List<Object?> get props => [
        id,
        name,
        username,
        phoneNumber,
        restaurantImageUrl,
        restaurantDescription,
        userType,
        authStatus,
      ];

  @override
  String toString() {
    if (userType == UserType.customer) {
      //if customer user type
      return '''
      Base user details : $id , $name , $username , $phoneNumber,
      $userType , $authStatus,
      ''';
    } else {
      //if restaurant user type
      return '''
      Base user details : $id , $name , $username , $phoneNumber,
      $restaurantImageUrl,$restaurantDescription, $userType , $authStatus,
      ''';
    }
  }

  /// Connect the generated [_$UserFromJson] function to the `fromJson`
  /// factory.
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Connect the generated [_$UserToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
