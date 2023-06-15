// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Item _$$_ItemFromJson(Map<String, dynamic> json) => _$_Item(
      id: json['id'] as int?,
      name: json['name'] as String,
      cost_retail: (json['cost_retail'] as num).toDouble(),
      cost_wholesale: (json['cost_wholesale'] as num?)?.toDouble(),
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      farmer: json['farmer'] as int?,
      number: (json['number'] as num).toDouble(),
      number_wholesale: (json['number_wholesale'] as num?)?.toDouble(),
      description: json['description'] as String,
      expire_date: json['expire_date'] == null
          ? null
          : DateTime.parse(json['expire_date'] as String),
      subscriptable: json['subscriptable'] as bool,
      number_for_month: (json['number_for_month'] as num?)?.toDouble(),
      category: json['category'] as String,
      doc: json['doc'] as String,
    );

Map<String, dynamic> _$$_ItemToJson(_$_Item instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'cost_retail': instance.cost_retail,
      'cost_wholesale': instance.cost_wholesale,
      'date': instance.date?.toIso8601String(),
      'farmer': instance.farmer,
      'number': instance.number,
      'number_wholesale': instance.number_wholesale,
      'description': instance.description,
      'expire_date': instance.expire_date?.toIso8601String(),
      'subscriptable': instance.subscriptable,
      'number_for_month': instance.number_for_month,
      'category': instance.category,
      'doc': instance.doc,
    };
