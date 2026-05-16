import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/utils/firestore_converters.dart';
import '../../core/utils/user_display_name.dart';
import '../../domain/entities/user.dart';
import '../../domain/enums/enums.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String fullName,
    required String email,
    String? phoneNumber,
    String? avatarUrl,
    required String major,
    @AcademicLevelConverter() required AcademicLevel academicLevel,
    double? gpa,
    @UserRoleConverter() required UserRole role,
    required bool isActive,
    required int reportCount,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(normalizeUserJson(json));

  factory UserModel.fromEntity(User entity) => UserModel(
        id: entity.id,
        fullName: entity.fullName,
        email: entity.email,
        phoneNumber: entity.phoneNumber,
        avatarUrl: entity.avatarUrl,
        major: entity.major,
        academicLevel: entity.academicLevel,
        gpa: entity.gpa,
        role: entity.role,
        isActive: entity.isActive,
        reportCount: entity.reportCount,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
      );
}

extension UserModelX on UserModel {
  User toEntity() => User(
        id: id,
        fullName: fullName,
        email: email,
        phoneNumber: phoneNumber,
        avatarUrl: avatarUrl,
        major: major,
        academicLevel: academicLevel,
        gpa: gpa,
        role: role,
        isActive: isActive,
        reportCount: reportCount,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
