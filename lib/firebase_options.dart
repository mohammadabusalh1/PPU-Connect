// Generated from google-services.json / flutterfire configure.
// Re-run `flutterfire configure` to add iOS / web / desktop configs.

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'Web is not configured yet. Run `flutterfire configure`.',
      );
    }
    return switch (defaultTargetPlatform) {
      TargetPlatform.android => android,
      TargetPlatform.iOS => throw UnsupportedError(
          'iOS is not configured yet. Run `flutterfire configure`.',
        ),
      TargetPlatform.macOS => throw UnsupportedError(
          'macOS is not configured yet. Run `flutterfire configure`.',
        ),
      TargetPlatform.windows => throw UnsupportedError(
          'Windows is not configured yet. Run `flutterfire configure`.',
        ),
      TargetPlatform.linux => throw UnsupportedError(
          'Linux is not configured yet. Run `flutterfire configure`.',
        ),
      _ => throw UnsupportedError('Unsupported platform.'),
    };
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDu6pgRVP8hxxZwgIOz_EADoA6FBAosM18',
    appId: '1:158326219223:android:8de016c2a7d9aa10a2eb92',
    messagingSenderId: '158326219223',
    projectId: 'ppucon',
    storageBucket: 'ppucon.firebasestorage.app',
  );
}
