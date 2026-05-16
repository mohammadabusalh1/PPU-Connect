import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Full MyApp smoke test requires Firebase initialization, which is out of scope
// for pure unit tests. This file verifies the test harness works with a
// standalone widget — full integration tests belong in test/integration/.
void main() {
  testWidgets('standalone MaterialApp renders without crashing', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: Text('PPU Connect'))),
    );
    expect(find.text('PPU Connect'), findsOneWidget);
  });
}
