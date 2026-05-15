import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('About PPU Connect')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Center(
            child: CircleAvatar(
              radius: 48,
              backgroundColor: cs.primaryContainer,
              child: Icon(Icons.school_rounded, size: 48, color: cs.primary),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              'PPU Connect',
              style: theme.textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          Center(
            child: Text(
              'Version 1.0.0',
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: cs.outline),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'PPU Connect is a peer tutoring platform for Palestine Polytechnic University students. Find tutors, schedule sessions, and manage your academic growth.',
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: const Text('Privacy Policy'),
            trailing: const Icon(Icons.open_in_new, size: 16),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: const Text('Terms of Service'),
            trailing: const Icon(Icons.open_in_new, size: 16),
            onTap: () {},
          ),
          const Divider(),
          const SizedBox(height: 16),
          Center(
            child: Text(
              '© 2025 Palestine Polytechnic University',
              style: theme.textTheme.bodySmall?.copyWith(color: cs.outline),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
