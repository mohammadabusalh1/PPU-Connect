import 'package:flutter/material.dart';
import 'package:ppu_connect/domain/enums/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ppu_connect/core/di/injection.dart';
import 'package:ppu_connect/presentation/blocs/auth/auth_bloc.dart';
import 'package:ppu_connect/presentation/cubits/browse_tutors/browse_tutors_cubit.dart';
import 'package:ppu_connect/presentation/cubits/profile_setup/profile_setup_cubit.dart';
import 'package:ppu_connect/presentation/cubits/appointment_requests/appointment_requests_cubit.dart';
import 'package:ppu_connect/presentation/cubits/profile/profile_cubit.dart';
import 'package:ppu_connect/presentation/cubits/notifications/notifications_cubit.dart';
import 'package:ppu_connect/presentation/cubits/schedule/schedule_cubit.dart';
import 'package:ppu_connect/presentation/cubits/tutor_availability/tutor_availability_cubit.dart';
import 'package:ppu_connect/presentation/pages/auth/forgot_password_page.dart';
import 'package:ppu_connect/presentation/pages/auth/login_page.dart';
import 'package:ppu_connect/presentation/pages/auth/register_page.dart';
import 'package:ppu_connect/presentation/pages/auth/splash_page.dart';
import 'package:ppu_connect/presentation/pages/auth/welcome_page.dart';
import 'package:ppu_connect/presentation/pages/discover/browse_tutoring_requests_page.dart';
import 'package:ppu_connect/presentation/pages/discover/discover_page.dart';
import 'package:ppu_connect/presentation/pages/discover/tutor_detail_page.dart';
import 'package:ppu_connect/presentation/pages/history/history_page.dart';
import 'package:ppu_connect/presentation/pages/notifications/notifications_page.dart';
import 'package:ppu_connect/presentation/pages/payments/payment_history_page.dart';
import 'package:ppu_connect/presentation/pages/profile/edit_profile_page.dart';
import 'package:ppu_connect/presentation/pages/profile/my_profile_page.dart';
import 'package:ppu_connect/presentation/pages/reports/my_reports_page.dart';
import 'package:ppu_connect/presentation/pages/reports/report_user_page.dart';
import 'package:ppu_connect/presentation/pages/requests/create_request_page.dart';
import 'package:ppu_connect/presentation/pages/requests/incoming_requests_page.dart';
import 'package:ppu_connect/presentation/pages/requests/request_detail_page.dart';
import 'package:ppu_connect/presentation/pages/requests/sent_requests_page.dart';
import 'package:ppu_connect/presentation/pages/reviews/my_reviews_page.dart';
import 'package:ppu_connect/presentation/pages/reviews/write_review_page.dart';
import 'package:ppu_connect/presentation/pages/schedule/appointment_detail_page.dart';
import 'package:ppu_connect/presentation/pages/schedule/cancel_appointment_page.dart';
import 'package:ppu_connect/presentation/pages/schedule/schedule_page.dart';
import 'package:ppu_connect/presentation/pages/session/session_confirmation_page.dart';
import 'package:ppu_connect/presentation/pages/settings/about_page.dart';
import 'package:ppu_connect/presentation/pages/settings/account_settings_page.dart';
import 'package:ppu_connect/presentation/pages/settings/notification_settings_page.dart';
import 'package:ppu_connect/presentation/pages/settings/privacy_settings_page.dart';
import 'package:ppu_connect/presentation/pages/settings/settings_page.dart';
import 'package:ppu_connect/presentation/pages/onboarding/onboarding_page.dart';
import 'package:ppu_connect/presentation/pages/shell/main_shell_page.dart';
import 'package:ppu_connect/presentation/pages/tutor/tutor_home_page.dart';
import 'package:ppu_connect/presentation/pages/tutor/tutor_profile_edit_page.dart';
import 'package:ppu_connect/presentation/pages/tutor/weekly_availability_page.dart';
import 'package:ppu_connect/presentation/pages/tutoring_requests/create_tutoring_request_page.dart';
import 'package:ppu_connect/presentation/pages/tutoring_requests/my_tutoring_requests_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _discoverShellKey = GlobalKey<NavigatorState>();
final _scheduleShellKey = GlobalKey<NavigatorState>();
final _historyShellKey = GlobalKey<NavigatorState>();
final _profileShellKey = GlobalKey<NavigatorState>();

GoRouter createRouter(AuthBloc authBloc) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    refreshListenable: _AuthStateListenable(authBloc),
    redirect: (context, state) {
      final authState = authBloc.state;
      final isAuth = authState is AuthAuthenticated;
        final isLoading = authState is AuthInitial;

      final authRoutes = {
        '/login',
        '/register',
        '/forgot-password',
        '/welcome'
      };
      final isOnAuthRoute = authRoutes.contains(state.matchedLocation);

      if (isLoading) return '/';
      if (!isAuth && state.matchedLocation == '/') return '/welcome';
      if (!isAuth && !isOnAuthRoute && state.matchedLocation != '/') {
        return '/welcome';
      }
      if (isAuth) {
        final user = (authState as AuthAuthenticated).user;
        final needsOnboarding = user.major.isEmpty;
        if (needsOnboarding && state.matchedLocation != '/onboarding') {
          return '/onboarding';
        }
        if (user.role == UserRole.tutor &&
            state.matchedLocation == '/requests/sent') {
          return '/schedule';
        }
        if (isOnAuthRoute) return '/discover';
        if (state.matchedLocation == '/') return '/discover';
      }
      return null;
    },
    routes: [
      // ── Splash ──────────────────────────────────────────────────────────────
      GoRoute(path: '/', builder: (_, __) => const SplashPage()),

      // ── Auth ─────────────────────────────────────────────────────────────────
      GoRoute(path: '/welcome', builder: (_, __) => const WelcomePage()),
      GoRoute(path: '/login', builder: (_, __) => const LoginPage()),
      GoRoute(path: '/register', builder: (_, __) => const RegisterPage()),
      GoRoute(
          path: '/forgot-password',
          builder: (_, __) => const ForgotPasswordPage()),

      // ── Onboarding ───────────────────────────────────────────────────────────
      GoRoute(
        path: '/onboarding',
        builder: (_, __) => BlocProvider(
          create: (_) => getIt<ProfileSetupCubit>(),
          child: const OnboardingPage(),
        ),
      ),

      // ── Main shell with 4 tab branches ──────────────────────────────────────
      StatefulShellRoute.indexedStack(
        builder: (_, __, shell) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => getIt<ProfileCubit>()),
            BlocProvider(
              create: (ctx) {
                final authState = ctx.read<AuthBloc>().state;
                final cubit = getIt<NotificationsCubit>();
                if (authState is AuthAuthenticated) {
                  cubit.watch(authState.user.id);
                }
                return cubit;
              },
            ),
          ],
          child: MainShellPage(navigationShell: shell),
        ),
        branches: [
          // Branch 0 — Discover (seekers) / Requests (tutors)
          StatefulShellBranch(
            navigatorKey: _discoverShellKey,
            routes: [
              GoRoute(
                path: '/discover',
                builder: (context, __) {
                  final authState = context.read<AuthBloc>().state;
                  final role = authState is AuthAuthenticated
                      ? authState.user.role
                      : UserRole.seeker;
                  if (role == UserRole.tutor) {
                    return BlocProvider(
                      create: (_) => getIt<AppointmentRequestsCubit>(),
                      child: const TutorHomePage(),
                    );
                  }
                  return BlocProvider(
                    create: (_) => getIt<BrowseTutorsCubit>(),
                    child: const DiscoverPage(),
                  );
                },
                routes: [
                  GoRoute(
                    path: 'tutors/:id',
                    builder: (_, state) =>
                        TutorDetailPage(tutorId: state.pathParameters['id']!),
                  ),
                  GoRoute(
                    path: 'tutoring-requests',
                    builder: (_, __) => const BrowseTutoringRequestsPage(),
                  ),
                ],
              ),
            ],
          ),
          // Branch 1 — Schedule
          StatefulShellBranch(
            navigatorKey: _scheduleShellKey,
            routes: [
              GoRoute(
                path: '/schedule',
                builder: (_, __) => BlocProvider(
                  create: (_) => getIt<ScheduleCubit>(),
                  child: const SchedulePage(),
                ),
                routes: [
                  GoRoute(
                    path: 'appointments/:id',
                    builder: (_, state) => AppointmentDetailPage(
                      appointmentId: state.pathParameters['id']!,
                    ),
                    routes: [
                      GoRoute(
                        path: 'cancel',
                        builder: (_, state) => CancelAppointmentPage(
                          appointmentId: state.pathParameters['id']!,
                        ),
                      ),
                      GoRoute(
                        path: 'confirm',
                        builder: (_, state) => SessionConfirmationPage(
                          appointmentId: state.pathParameters['id']!,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          // Branch 2 — History
          StatefulShellBranch(
            navigatorKey: _historyShellKey,
            routes: [
              GoRoute(
                path: '/history',
                builder: (_, __) => BlocProvider(
                  create: (_) => getIt<ScheduleCubit>(),
                  child: const HistoryPage(),
                ),
              ),
            ],
          ),
          // Branch 3 — Profile
          StatefulShellBranch(
            navigatorKey: _profileShellKey,
            routes: [
              GoRoute(
                path: '/profile',
                builder: (_, __) => const MyProfilePage(),
                routes: [
                  GoRoute(
                    path: 'edit',
                    builder: (_, __) => const EditProfilePage(),
                  ),
                  GoRoute(
                    path: 'tutor-edit',
                    builder: (_, __) => const TutorProfileEditPage(),
                  ),
                  GoRoute(
                    path: 'availability',
                    builder: (_, __) => const WeeklyAvailabilityPage(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),

      // ── Notifications (root navigator — pushed from shell tabs) ────────────
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/notifications',
        builder: (_, __) => const NotificationsPage(),
      ),

      // ── Appointment Requests (root navigator — pushed from shell tabs) ─────
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/requests/incoming',
        builder: (_, __) => BlocProvider(
          create: (_) => getIt<AppointmentRequestsCubit>(),
          child: const IncomingRequestsPage(),
        ),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/requests/sent',
        builder: (_, __) => BlocProvider(
          create: (_) => getIt<AppointmentRequestsCubit>(),
          child: const SentRequestsPage(),
        ),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/requests/create',
        builder: (_, state) {
          final tutorId = state.uri.queryParameters['tutorId'] ?? '';
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => getIt<AppointmentRequestsCubit>()),
              BlocProvider(
                create: (_) =>
                    getIt<TutorAvailabilityCubit>()..load(tutorId),
              ),
            ],
            child: CreateRequestPage(tutorId: tutorId),
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/requests/:id',
        builder: (_, state) => BlocProvider(
          create: (_) => getIt<AppointmentRequestsCubit>(),
          child: RequestDetailPage(requestId: state.pathParameters['id']!),
        ),
      ),

      // ── Tutoring Requests ────────────────────────────────────────────────────
      GoRoute(
        path: '/tutoring-requests',
        builder: (_, __) => const MyTutoringRequestsPage(),
      ),
      GoRoute(
        path: '/tutoring-requests/create',
        builder: (_, __) => const CreateTutoringRequestPage(),
      ),

      // ── Reviews (root navigator — pushed from profile shell tab) ───────────
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/reviews/write',
        builder: (_, state) => WriteReviewPage(
          appointmentId: state.uri.queryParameters['appointmentId'] ?? '',
          tutorId: state.uri.queryParameters['tutorId'] ?? '',
        ),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/reviews/my',
        builder: (_, __) => const MyReviewsPage(),
      ),

      // ── Payments (root navigator — pushed from profile shell tab) ──────────
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/payments',
        builder: (_, __) => const PaymentHistoryPage(),
      ),

      // ── Reports (root navigator — pushed from profile shell tab) ─────────────
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/reports/create',
        builder: (_, state) => ReportUserPage(
          reportedId: state.uri.queryParameters['reportedId'] ?? '',
        ),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/reports/my',
        builder: (_, __) => const MyReportsPage(),
      ),

      // ── Settings ─────────────────────────────────────────────────────────────
      GoRoute(
        path: '/settings',
        builder: (_, __) => const SettingsPage(),
        routes: [
          GoRoute(
            path: 'account',
            builder: (_, __) => const AccountSettingsPage(),
          ),
          GoRoute(
            path: 'privacy',
            builder: (_, __) => const PrivacySettingsPage(),
          ),
          GoRoute(
            path: 'notifications',
            builder: (_, __) => const NotificationSettingsPage(),
          ),
          GoRoute(
            path: 'about',
            builder: (_, __) => const AboutPage(),
          ),
        ],
      ),
    ],
  );
}

class _AuthStateListenable extends ChangeNotifier {
  _AuthStateListenable(this._bloc) {
    _sub = _bloc.stream.listen((_) => notifyListeners());
  }

  final AuthBloc _bloc;
  late final dynamic _sub;

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}
