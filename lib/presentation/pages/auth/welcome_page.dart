import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:ppu_connect/core/constants/app_constants.dart';
import 'package:ppu_connect/presentation/widgets/buttons/outlined_action_button.dart';
import 'package:ppu_connect/presentation/widgets/buttons/primary_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      cs.primaryContainer.withOpacity(0.35),
                      cs.surface,
                    ],
                  ),
                ),
                child: Image.asset(
                  'assets/images/welcom_face.png',
                  height: 240,
                  fit: BoxFit.cover,
                ),
              )
                  .animate()
                  .fadeIn(duration: AppDurations.slow)
                  .slideY(begin: 0.1, end: 0),
              const SizedBox(height: 32),
              const SizedBox(height: 16),
              Text(
                'PPU Connect',
                style: tt.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
              ).animate().fadeIn(delay: AppDurations.fast),
              const SizedBox(height: 8),
              Text(
                'Book tutoring sessions with fellow\nPPU students',
                style: tt.bodyLarge?.copyWith(color: cs.onSurfaceVariant),
                textAlign: TextAlign.center,
              ).animate().fadeIn(delay: AppDurations.medium),
              const Spacer(),
              PrimaryButton(
                label: 'Sign in',
                onPressed: () => context.push('/login'),
              ).animate().fadeIn(delay: AppDurations.slow).slideY(begin: 0.2),
              const SizedBox(height: 12),
              OutlinedActionButton(
                label: 'Create account',
                onPressed: () => context.push('/register'),
              ).animate().fadeIn(delay: AppDurations.slow).slideY(begin: 0.2),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
