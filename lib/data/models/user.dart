import 'package:freezed_annotation/freezed_annotation.dart';

import 'card.dart';
part 'user.freezed.dart';
part 'user.g.dart';

enum UserType { FM, BY, AD }

@freezed
class User with _$User {
  const factory User({
    int? id,
    required String name,
    required UserType role,
    String? address,
    String? phone_number,
    String? email,
    String? password,
    required double rate,
    Card? card,
  }) = _User;

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}
