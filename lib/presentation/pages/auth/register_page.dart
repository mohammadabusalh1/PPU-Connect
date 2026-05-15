import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ppu_connect/core/mixins/form_validation_mixin.dart';
import 'package:ppu_connect/presentation/blocs/auth/auth_bloc.dart';
import 'package:ppu_connect/presentation/widgets/buttons/primary_button.dart';
import 'package:ppu_connect/presentation/widgets/feedback/error_banner.dart';
import 'package:ppu_connect/presentation/widgets/form/email_text_field.dart';
import 'package:ppu_connect/presentation/widgets/form/full_name_text_field.dart';
import 'package:ppu_connect/presentation/widgets/form/password_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with FormValidationMixin<RegisterPage> {
  late final TextEditingController _fullName;
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _confirmPassword;
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _fullName = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    _confirmPassword = TextEditingController();
  }

  @override
  void dispose() {
    _fullName.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmFocus.dispose();
    super.dispose();
  }

  void _submit() {
    if (!validateForm()) return;
    context.read<AuthBloc>().add(
          AuthRegisterRequested(
            email: _email.text.trim(),
            password: _password.text,
            fullName: _fullName.text.trim(),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create account')),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) context.go('/onboarding');
        },
        builder: (context, state) {
          final loading = state is AuthLoading;
          final error = state is AuthError ? state.message : '';

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: formKey,
              child: AutofillGroup(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      'Join PPU Connect',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Use your PPU email to register',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                    const SizedBox(height: 32),
                    if (error.isNotEmpty) ...[
                      ErrorBanner(message: error),
                      const SizedBox(height: 16),
                    ],
                    FullNameTextField(
                      controller: _fullName,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(_emailFocus),
                    ),
                    const SizedBox(height: 16),
                    EmailTextField(
                      controller: _email,
                      focusNode: _emailFocus,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(_passwordFocus),
                    ),
                    const SizedBox(height: 16),
                    PasswordTextField(
                      controller: _password,
                      focusNode: _passwordFocus,
                      label: 'Password',
                      showStrengthBar: true,
                      autofillHint: AutofillHints.newPassword,
                      enableAutofill: false,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(_confirmFocus),
                    ),
                    const SizedBox(height: 16),
                    PasswordTextField(
                      controller: _confirmPassword,
                      focusNode: _confirmFocus,
                      label: 'Confirm password',
                      textInputAction: TextInputAction.done,
                      autofillHint: AutofillHints.newPassword,
                      enableAutofill: false,
                      validator: (v) => v != _password.text
                          ? 'Passwords do not match'
                          : null,
                      onFieldSubmitted: (_) => _submit(),
                    ),
                    const SizedBox(height: 32),
                    PrimaryButton(
                      label: 'Create account',
                      loading: loading,
                      onPressed: _submit,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account?'),
                        TextButton(
                          onPressed: () => context.pushReplacement('/login'),
                          child: const Text('Sign in'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
