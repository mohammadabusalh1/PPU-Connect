import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:ppu_connect/domain/entities/user.dart';
import 'package:ppu_connect/domain/use_cases/auth/register.dart';
import 'package:ppu_connect/domain/use_cases/auth/send_password_reset.dart';
import 'package:ppu_connect/domain/use_cases/auth/sign_in.dart';
import 'package:ppu_connect/domain/use_cases/auth/sign_in_with_google.dart';
import 'package:ppu_connect/domain/use_cases/auth/sign_out.dart';
import 'package:ppu_connect/domain/use_cases/auth/watch_auth_state.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(
    this._watchAuthState,
    this._signIn,
    this._register,
    this._signOut,
    this._sendPasswordReset,
    this._signInWithGoogle,
  ) : super(const AuthInitial()) {
    on<AuthStarted>(_onStarted);
    on<AuthUserChanged>(_onUserChanged);
    on<AuthSignInRequested>(_onSignIn);
    on<AuthRegisterRequested>(_onRegister);
    on<AuthSignOutRequested>(_onSignOut);
    on<AuthPasswordResetRequested>(_onPasswordReset);
    on<AuthGoogleSignInRequested>(_onGoogleSignIn);
  }

  final WatchAuthState _watchAuthState;
  final SignIn _signIn;
  final Register _register;
  final SignOut _signOut;
  final SendPasswordReset _sendPasswordReset;
  final SignInWithGoogle _signInWithGoogle;

  StreamSubscription<User?>? _authSub;

  Future<void> _onStarted(
    AuthStarted event,
    Emitter<AuthState> emit,
  ) async {
    await emit.forEach<User?>(
      _watchAuthState(),
      onData: (user) =>
          user != null ? AuthAuthenticated(user) : const AuthUnauthenticated(),
      onError: (_, __) => const AuthUnauthenticated(),
    );
  }

  void _onUserChanged(AuthUserChanged event, Emitter<AuthState> emit) {
    if (event.user != null) {
      emit(AuthAuthenticated(event.user!));
    } else {
      emit(const AuthUnauthenticated());
    }
  }

  Future<void> _onSignIn(
    AuthSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      final user = await _signIn(event.email, event.password);
      if (isClosed) return;
      emit(AuthAuthenticated(user));
    } catch (e) {
      if (isClosed) return;
      emit(AuthError(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<void> _onRegister(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      final user = await _register(
        email: event.email,
        password: event.password,
        fullName: event.fullName,
      );
      if (isClosed) return;
      emit(AuthAuthenticated(user));
    } catch (e) {
      if (isClosed) return;
      emit(AuthError(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<void> _onSignOut(
    AuthSignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _signOut();
    if (isClosed) return;
    emit(const AuthUnauthenticated());
  }

  Future<void> _onPasswordReset(
    AuthPasswordResetRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      await _sendPasswordReset(event.email);
      if (isClosed) return;
      emit(AuthPasswordResetSent(event.email));
    } catch (e) {
      if (isClosed) return;
      emit(AuthError(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<void> _onGoogleSignIn(
    AuthGoogleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      final user = await _signInWithGoogle();
      if (isClosed) return;
      emit(AuthAuthenticated(user));
    } catch (e) {
      if (isClosed) return;
      emit(AuthError(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  @override
  Future<void> close() {
    _authSub?.cancel();
    return super.close();
  }
}
