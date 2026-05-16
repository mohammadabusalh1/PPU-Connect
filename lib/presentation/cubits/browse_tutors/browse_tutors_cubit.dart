import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:ppu_connect/domain/entities/tutor_with_user.dart';
import 'package:ppu_connect/domain/entities/user_display.dart';
import 'package:ppu_connect/domain/repositories/tutor_profile_repository.dart';
import 'package:ppu_connect/domain/repositories/user_repository.dart';

part 'browse_tutors_state.dart';

@injectable
class BrowseTutorsCubit extends Cubit<BrowseTutorsState> {
  BrowseTutorsCubit(this._tutorRepo, this._userRepo)
      : super(const BrowseTutorsInitial());

  final TutorProfileRepository _tutorRepo;
  final UserRepository _userRepo;

  Future<void> load({String? query, double? maxRate, String? currentUserId}) async {
    emit(const BrowseTutorsLoading());
    try {
      final profiles = await _tutorRepo.searchTutors(maxRate: maxRate);
      final users = await Future.wait(
        profiles.map((p) => _userRepo.getUserById(p.userId)),
      );
      if (isClosed) return;
      final result = <TutorWithUser>[];
      for (var i = 0; i < profiles.length; i++) {
        final u = users[i];
        if (u != null && u.id != currentUserId) {
          result.add(TutorWithUser(user: u, profile: profiles[i]));
        }
      }
      final trimmedQuery = query?.trim();
      if (trimmedQuery != null && trimmedQuery.isNotEmpty) {
        final q = trimmedQuery.toLowerCase();
        result.retainWhere((t) {
          final name = t.user.displayName.toLowerCase();
          final subjects = t.profile.subjects
              .map((s) => s.toLowerCase())
              .join(' ');
          return name.contains(q) || subjects.contains(q);
        });
      }
      emit(BrowseTutorsLoaded(tutors: result, query: query));
    } catch (e) {
      if (isClosed) return;
      emit(BrowseTutorsError(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
