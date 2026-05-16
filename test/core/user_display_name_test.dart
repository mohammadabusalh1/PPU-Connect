import 'package:flutter_test/flutter_test.dart';
import 'package:ppu_connect/core/utils/user_display_name.dart';

void main() {
  test('returns trimmed fullName when present', () {
    expect(
      resolveUserDisplayName(
        fullName: '  Jane Doe  ',
        email: 'jane@ppu.edu',
      ),
      'Jane Doe',
    );
  });

  test('derives name from email local part', () {
    expect(
      resolveUserDisplayName(fullName: '', email: 'ahmad.hassan@ppu.edu'),
      'Ahmad Hassan',
    );
  });

  test('uses fallback when name and email are empty', () {
    expect(
      resolveUserDisplayName(fullName: '', email: '', fallback: 'Tutor'),
      'Tutor',
    );
  });

  test('normalizeUserJson fills missing fullName from email', () {
    final json = normalizeUserJson({
      'id': 'u1',
      'fullName': '',
      'email': 'tutor.user@ppu.edu',
      'major': 'CS',
      'academicLevel': 'firstYear',
      'role': 'tutor',
      'isActive': true,
      'reportCount': 0,
      'createdAt': DateTime(2024),
      'updatedAt': DateTime(2024),
    });

    expect(json['fullName'], 'Tutor User');
  });
}
