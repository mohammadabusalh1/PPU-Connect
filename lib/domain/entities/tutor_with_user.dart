import 'package:ppu_connect/domain/entities/tutor_profile.dart';
import 'package:ppu_connect/domain/entities/user.dart';

class TutorWithUser {
  const TutorWithUser({required this.user, required this.profile});

  final User user;
  final TutorProfile profile;
}
