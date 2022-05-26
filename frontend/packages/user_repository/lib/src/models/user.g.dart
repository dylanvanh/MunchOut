// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int?,
      name: json['name'] as String?,
      username: json['username'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      restaurantImageUrl: json['restaurantImageUrl'] as String?,
      restaurantDescription: json['restaurantDescription'] as String?,
      userType: $enumDecodeNullable(_$UserTypeEnumMap, json['userType']),
      authStatus: $enumDecodeNullable(
              _$AuthenticationStatusEnumMap, json['authStatus']) ??
          AuthenticationStatus.unauthenticated,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'username': instance.username,
      'phoneNumber': instance.phoneNumber,
      'restaurantImageUrl': instance.restaurantImageUrl,
      'restaurantDescription': instance.restaurantDescription,
      'userType': _$UserTypeEnumMap[instance.userType],
      'authStatus': _$AuthenticationStatusEnumMap[instance.authStatus],
    };

const _$UserTypeEnumMap = {
  UserType.customer: 'customer',
  UserType.restaurant: 'restaurant',
};

const _$AuthenticationStatusEnumMap = {
  AuthenticationStatus.unauthenticated: 'unauthenticated',
  AuthenticationStatus.authenticated: 'authenticated',
};
