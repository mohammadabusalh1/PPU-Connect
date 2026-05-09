import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/enums.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String fullName,
    required String email,
    String? phoneNumber,
    String? avatarUrl,
    required String major,
    required AcademicLevel academicLevel,
    double? gpa,
    required UserRole role,
    required bool isActive,
    required int reportCount,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _User;
}
