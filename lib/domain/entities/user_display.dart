import 'package:ppu_connect/core/utils/user_display_name.dart';
import 'package:ppu_connect/domain/entities/user.dart';
import 'package:ppu_connect/domain/enums/enums.dart';

extension UserDisplayX on User {
  String get displayName => resolveUserDisplayName(
        fullName: fullName,
        email: email,
        fallback: role == UserRole.seeker ? 'User' : 'Tutor',
      );
}
