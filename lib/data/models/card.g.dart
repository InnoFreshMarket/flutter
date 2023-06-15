// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Card _$$_CardFromJson(Map<String, dynamic> json) => _$_Card(
      id: json['id'] as int,
      number: json['number'] as String,
      name: json['name'] as String,
      date: DateTime.parse(json['date'] as String),
      cvc: json['cvc'] as String,
    );

Map<String, dynamic> _$$_CardToJson(_$_Card instance) => <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'name': instance.name,
      'date': instance.date.toIso8601String(),
      'cvc': instance.cvc,
    };
