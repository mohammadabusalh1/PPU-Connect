import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ppu_connect/app/my_app.dart';
import 'package:ppu_connect/core/di/injection.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  configureDependencies();
  runApp(const MyApp());
}
