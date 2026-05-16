import 'package:flutter_test/flutter_test.dart';
import 'package:ppu_connect/data/models/user_model.dart';
import 'package:ppu_connect/domain/enums/enums.dart';

void main() {
  test('registration user model serializes fields for Firestore', () {
    final createdAt = DateTime.utc(2026, 3, 1, 12);
    final model = UserModel(
      id: 'uid-1',
      fullName: 'Ahmad Ali',
      email: 'ahmad@ppu.edu',
      major: '',
      academicLevel: AcademicLevel.firstYear,
      role: UserRole.seeker,
      isActive: true,
      reportCount: 0,
      createdAt: createdAt,
      updatedAt: createdAt,
    );

    final json = model.toJson();

    expect(json['fullName'], 'Ahmad Ali');
    expect(json['email'], 'ahmad@ppu.edu');
    expect(json['major'], '');
    expect(json['role'], 'seeker');
    expect(json['academicLevel'], 'firstYear');
    expect(json['createdAt'], isNotNull);
    expect(json['updatedAt'], isNotNull);

    final decoded = UserModel.fromJson(json);
    expect(decoded.fullName, 'Ahmad Ali');
    expect(decoded.email, 'ahmad@ppu.edu');
  });
}
