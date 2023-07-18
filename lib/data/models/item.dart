import 'package:freezed_annotation/freezed_annotation.dart';

import 'user.dart';
part 'item.freezed.dart';
part 'item.g.dart';

// ['id', 'name', 'cost_retail', 'cost_wholesale',
//           'date', 'farmer', 'number', 'number_wholesale',
//           'description', 'expire_date', 'number_for_month',
//           'subscriptable', 'category', 'doc']

@freezed
class Item with _$Item {
  const factory Item({
    int? id,
    required String name,
    required double cost_retail,
    double? cost_wholesale,
    String? date,
    required int farmer,
    required double number,
    double? number_wholesale,
    required String description,
    String? expire_date,
    required bool subscriptable,
    double? number_for_month,
    required String category,
    required String doc,
  }) = _Item;

  factory Item.fromJson(Map<String, Object?> json) => _$ItemFromJson(json);
}
