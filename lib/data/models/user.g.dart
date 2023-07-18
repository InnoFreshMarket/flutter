// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$$_UserFromJson(Map<String, dynamic> json) => _$_User(
      id: json['id'] as int?,
      name: json['name'] as String,
      role: $enumDecode(_$UserTypeEnumMap, json['role']),
      address: json['address'] as String?,
      phone_number: json['phone_number'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      rate: (json['rate'] as num).toDouble(),
      card: json['card'] == null
          ? null
          : Card.fromJson(json['card'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'role': _$UserTypeEnumMap[instance.role]!,
      'address': instance.address,
      'phone_number': instance.phone_number,
      'email': instance.email,
      'password': instance.password,
      'rate': instance.rate,
      'card': instance.card,
    };

const _$UserTypeEnumMap = {
  UserType.FM: 'FM',
  UserType.BY: 'BY',
  UserType.AD: 'AD',
};
