// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:firebase_storage/firebase_storage.dart' as _i457;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:ppu_connect/core/di/injection.dart' as _i491;
import 'package:ppu_connect/data/datasources/appointment_remote_data_source.dart'
    as _i801;
import 'package:ppu_connect/data/datasources/auth_remote_data_source.dart'
    as _i458;
import 'package:ppu_connect/data/datasources/notification_remote_data_source.dart'
    as _i915;
import 'package:ppu_connect/data/datasources/payment_remote_data_source.dart'
    as _i204;
import 'package:ppu_connect/data/datasources/report_remote_data_source.dart'
    as _i89;
import 'package:ppu_connect/data/datasources/review_remote_data_source.dart'
    as _i45;
import 'package:ppu_connect/data/datasources/session_confirmation_remote_data_source.dart'
    as _i396;
import 'package:ppu_connect/data/datasources/tutor_profile_remote_data_source.dart'
    as _i82;
import 'package:ppu_connect/data/datasources/tutoring_request_remote_data_source.dart'
    as _i1019;
import 'package:ppu_connect/data/datasources/user_remote_data_source.dart'
    as _i859;
import 'package:ppu_connect/data/repositories/appointment_repository_impl.dart'
    as _i845;
import 'package:ppu_connect/data/repositories/auth_repository_impl.dart'
    as _i442;
import 'package:ppu_connect/data/repositories/notification_repository_impl.dart'
    as _i800;
import 'package:ppu_connect/data/repositories/payment_repository_impl.dart'
    as _i742;
import 'package:ppu_connect/data/repositories/report_repository_impl.dart'
    as _i1004;
import 'package:ppu_connect/data/repositories/review_repository_impl.dart'
    as _i340;
import 'package:ppu_connect/data/repositories/session_confirmation_repository_impl.dart'
    as _i401;
import 'package:ppu_connect/data/repositories/tutor_profile_repository_impl.dart'
    as _i718;
import 'package:ppu_connect/data/repositories/tutoring_request_repository_impl.dart'
    as _i217;
import 'package:ppu_connect/data/repositories/user_repository_impl.dart'
    as _i358;
import 'package:ppu_connect/data/repositories/weekly_slot_repository_impl.dart'
    as _i741;
import 'package:ppu_connect/domain/repositories/appointment_repository.dart'
    as _i161;
import 'package:ppu_connect/domain/repositories/auth_repository.dart' as _i475;
import 'package:ppu_connect/domain/repositories/notification_repository.dart'
    as _i301;
import 'package:ppu_connect/domain/repositories/payment_repository.dart'
    as _i150;
import 'package:ppu_connect/domain/repositories/report_repository.dart'
    as _i855;
import 'package:ppu_connect/domain/repositories/review_repository.dart'
    as _i139;
import 'package:ppu_connect/domain/repositories/session_confirmation_repository.dart'
    as _i325;
import 'package:ppu_connect/domain/repositories/tutor_profile_repository.dart'
    as _i876;
import 'package:ppu_connect/domain/repositories/tutoring_request_repository.dart'
    as _i382;
import 'package:ppu_connect/domain/repositories/user_repository.dart' as _i263;
import 'package:ppu_connect/domain/repositories/weekly_slot_repository.dart'
    as _i748;
import 'package:ppu_connect/domain/use_cases/auth/get_current_user.dart'
    as _i598;
import 'package:ppu_connect/domain/use_cases/auth/register.dart' as _i488;
import 'package:ppu_connect/domain/use_cases/auth/send_password_reset.dart'
    as _i103;
import 'package:ppu_connect/domain/use_cases/auth/sign_in.dart' as _i1016;
import 'package:ppu_connect/domain/use_cases/auth/sign_in_with_google.dart'
    as _i724;
import 'package:ppu_connect/domain/use_cases/auth/sign_out.dart' as _i1026;
import 'package:ppu_connect/domain/use_cases/auth/watch_auth_state.dart'
    as _i246;
import 'package:ppu_connect/presentation/blocs/auth/auth_bloc.dart' as _i509;
import 'package:ppu_connect/presentation/cubits/appointment_requests/appointment_requests_cubit.dart'
    as _i77;
import 'package:ppu_connect/presentation/cubits/browse_tutors/browse_tutors_cubit.dart'
    as _i1018;
import 'package:ppu_connect/presentation/cubits/checkout/checkout_cubit.dart'
    as _i528;
import 'package:ppu_connect/presentation/cubits/notifications/notifications_cubit.dart'
    as _i549;
import 'package:ppu_connect/presentation/cubits/payments/payments_cubit.dart'
    as _i983;
import 'package:ppu_connect/presentation/cubits/profile/profile_cubit.dart'
    as _i1050;
import 'package:ppu_connect/presentation/cubits/profile_setup/profile_setup_cubit.dart'
    as _i1042;
import 'package:ppu_connect/presentation/cubits/reports/reports_cubit.dart'
    as _i76;
import 'package:ppu_connect/presentation/cubits/reviews/reviews_cubit.dart'
    as _i1032;
import 'package:ppu_connect/presentation/cubits/schedule/schedule_cubit.dart'
    as _i979;
import 'package:ppu_connect/presentation/cubits/tutor_availability/tutor_availability_cubit.dart'
    as _i837;
import 'package:ppu_connect/presentation/cubits/tutoring_requests/tutoring_requests_cubit.dart'
    as _i973;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final firebaseModule = _$FirebaseModule();
    gh.singleton<_i59.FirebaseAuth>(() => firebaseModule.firebaseAuth);
    gh.singleton<_i974.FirebaseFirestore>(
      () => firebaseModule.firebaseFirestore,
    );
    gh.singleton<_i457.FirebaseStorage>(() => firebaseModule.firebaseStorage);
    gh.factory<_i204.PaymentRemoteDataSource>(
      () => _i204.PaymentRemoteDataSourceImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.factory<_i458.AuthRemoteDataSource>(
      () => _i458.AuthRemoteDataSourceImpl(
        gh<_i59.FirebaseAuth>(),
        gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.factory<_i1019.TutoringRequestRemoteDataSource>(
      () => _i1019.TutoringRequestRemoteDataSourceImpl(
        gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.factory<_i915.NotificationRemoteDataSource>(
      () =>
          _i915.NotificationRemoteDataSourceImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.factory<_i45.ReviewRemoteDataSource>(
      () => _i45.ReviewRemoteDataSourceImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.factory<_i382.TutoringRequestRepository>(
      () => _i217.TutoringRequestRepositoryImpl(
        gh<_i1019.TutoringRequestRemoteDataSource>(),
      ),
    );
    gh.factory<_i301.NotificationRepository>(
      () => _i800.NotificationRepositoryImpl(
        gh<_i915.NotificationRemoteDataSource>(),
      ),
    );
    gh.factory<_i859.UserRemoteDataSource>(
      () => _i859.UserRemoteDataSourceImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.factory<_i82.TutorProfileRemoteDataSource>(
      () =>
          _i82.TutorProfileRemoteDataSourceImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.factory<_i748.WeeklySlotRepository>(
      () => _i741.WeeklySlotRepositoryImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.factory<_i801.AppointmentRemoteDataSource>(
      () =>
          _i801.AppointmentRemoteDataSourceImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.factory<_i263.UserRepository>(
      () => _i358.UserRepositoryImpl(gh<_i859.UserRemoteDataSource>()),
    );
    gh.factory<_i89.ReportRemoteDataSource>(
      () => _i89.ReportRemoteDataSourceImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.factory<_i396.SessionConfirmationRemoteDataSource>(
      () => _i396.SessionConfirmationRemoteDataSourceImpl(
        gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.factory<_i475.AuthRepository>(
      () => _i442.AuthRepositoryImpl(gh<_i458.AuthRemoteDataSource>()),
    );
    gh.factory<_i549.NotificationsCubit>(
      () => _i549.NotificationsCubit(gh<_i301.NotificationRepository>()),
    );
    gh.factory<_i973.TutoringRequestsCubit>(
      () => _i973.TutoringRequestsCubit(gh<_i382.TutoringRequestRepository>()),
    );
    gh.factory<_i598.GetCurrentUser>(
      () => _i598.GetCurrentUser(gh<_i475.AuthRepository>()),
    );
    gh.factory<_i488.Register>(
      () => _i488.Register(gh<_i475.AuthRepository>()),
    );
    gh.factory<_i103.SendPasswordReset>(
      () => _i103.SendPasswordReset(gh<_i475.AuthRepository>()),
    );
    gh.factory<_i1016.SignIn>(() => _i1016.SignIn(gh<_i475.AuthRepository>()));
    gh.factory<_i724.SignInWithGoogle>(
      () => _i724.SignInWithGoogle(gh<_i475.AuthRepository>()),
    );
    gh.factory<_i1026.SignOut>(
      () => _i1026.SignOut(gh<_i475.AuthRepository>()),
    );
    gh.factory<_i246.WatchAuthState>(
      () => _i246.WatchAuthState(gh<_i475.AuthRepository>()),
    );
    gh.factory<_i150.PaymentRepository>(
      () => _i742.PaymentRepositoryImpl(gh<_i204.PaymentRemoteDataSource>()),
    );
    gh.factory<_i855.ReportRepository>(
      () => _i1004.ReportRepositoryImpl(gh<_i89.ReportRemoteDataSource>()),
    );
    gh.factory<_i139.ReviewRepository>(
      () => _i340.ReviewRepositoryImpl(gh<_i45.ReviewRemoteDataSource>()),
    );
    gh.factory<_i983.PaymentsCubit>(
      () => _i983.PaymentsCubit(gh<_i150.PaymentRepository>()),
    );
    gh.factory<_i876.TutorProfileRepository>(
      () => _i718.TutorProfileRepositoryImpl(
        gh<_i82.TutorProfileRemoteDataSource>(),
      ),
    );
    gh.factory<_i509.AuthBloc>(
      () => _i509.AuthBloc(
        gh<_i246.WatchAuthState>(),
        gh<_i1016.SignIn>(),
        gh<_i488.Register>(),
        gh<_i1026.SignOut>(),
        gh<_i103.SendPasswordReset>(),
        gh<_i724.SignInWithGoogle>(),
      ),
    );
    gh.factory<_i1018.BrowseTutorsCubit>(
      () => _i1018.BrowseTutorsCubit(
        gh<_i876.TutorProfileRepository>(),
        gh<_i263.UserRepository>(),
      ),
    );
    gh.factory<_i325.SessionConfirmationRepository>(
      () => _i401.SessionConfirmationRepositoryImpl(
        gh<_i396.SessionConfirmationRemoteDataSource>(),
      ),
    );
    gh.factory<_i1050.ProfileCubit>(
      () => _i1050.ProfileCubit(
        gh<_i263.UserRepository>(),
        gh<_i876.TutorProfileRepository>(),
      ),
    );
    gh.factory<_i1042.ProfileSetupCubit>(
      () => _i1042.ProfileSetupCubit(
        gh<_i263.UserRepository>(),
        gh<_i876.TutorProfileRepository>(),
      ),
    );
    gh.factory<_i1032.ReviewsCubit>(
      () => _i1032.ReviewsCubit(gh<_i139.ReviewRepository>()),
    );
    gh.factory<_i161.AppointmentRepository>(
      () => _i845.AppointmentRepositoryImpl(
        gh<_i801.AppointmentRemoteDataSource>(),
        gh<_i876.TutorProfileRepository>(),
        gh<_i263.UserRepository>(),
        gh<_i301.NotificationRepository>(),
      ),
    );
    gh.factory<_i528.CheckoutCubit>(
      () => _i528.CheckoutCubit(
        gh<_i161.AppointmentRepository>(),
        gh<_i150.PaymentRepository>(),
      ),
    );
    gh.factory<_i76.ReportsCubit>(
      () => _i76.ReportsCubit(gh<_i855.ReportRepository>()),
    );
    gh.factory<_i837.TutorAvailabilityCubit>(
      () => _i837.TutorAvailabilityCubit(
        gh<_i876.TutorProfileRepository>(),
        gh<_i161.AppointmentRepository>(),
      ),
    );
    gh.factory<_i77.AppointmentRequestsCubit>(
      () => _i77.AppointmentRequestsCubit(gh<_i161.AppointmentRepository>()),
    );
    gh.factory<_i979.ScheduleCubit>(
      () => _i979.ScheduleCubit(gh<_i161.AppointmentRepository>()),
    );
    return this;
  }
}

class _$FirebaseModule extends _i491.FirebaseModule {}
