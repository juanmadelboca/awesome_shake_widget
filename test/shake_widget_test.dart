import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:awesome_shake_widget/enum/shake_preset.dart';
import 'package:awesome_shake_widget/shake_widget.dart';

void main() {
  testWidgets('ShakeWidget renders its child', (WidgetTester tester) async {
    final testKey = Key('child-key');

    await tester.pumpWidget(
      MaterialApp(
        home: ShakeWidget(
          preset: ShakePreset.medium,
          child: Container(key: testKey),
        ),
      ),
    );

    expect(find.byKey(testKey), findsOneWidget);
  });

  testWidgets('ShakeWidget can be triggered via GlobalKey', (WidgetTester tester) async {
    final shakeKey = GlobalKey<ShakeWidgetState>();

    await tester.pumpWidget(
      MaterialApp(
        home: ShakeWidget(
          key: shakeKey,
          preset: ShakePreset.light,
          child: const Text('Shakeable'),
        ),
      ),
    );

    // Trigger shake (just verify no exception)
    shakeKey.currentState?.shake();
    await tester.pump(); // trigger animation frame
  });
}
