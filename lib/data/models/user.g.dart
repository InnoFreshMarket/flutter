// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$$_UserFromJson(Map<String, dynamic> json) => _$_User(
      id: json['id'] as int,
      name: json['name'] as String,
      role: $enumDecode(_$UserTypeEnumMap, json['role']),
      address: json['address'] as String?,
      phone: json['phone'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      card: json['card'] == null
          ? null
          : Card.fromJson(json['card'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'role': _$UserTypeEnumMap[instance.role]!,
      'address': instance.address,
      'phone': instance.phone,
      'email': instance.email,
      'password': instance.password,
      'card': instance.card,
    };

const _$UserTypeEnumMap = {
  UserType.FM: 'FM',
  UserType.BY: 'BY',
  UserType.AD: 'AD',
};
