import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:l5_rupan_a2/main.dart';

/// Walks through every screen and saves a screenshot of each.
/// Run with:
///   flutter drive --driver=test_driver/integration_test.dart \
///     --target=integration_test/screenshots_test.dart
void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Future<void> shot(WidgetTester tester, String name) async {
    await tester.pumpAndSettle();
    // Let the iOS page transition fully finish before capturing.
    await Future<void>.delayed(const Duration(milliseconds: 800));
    await tester.pumpAndSettle();
    await binding.takeScreenshot(name);
  }

  Future<void> back(WidgetTester tester) async {
    await tester.pageBack();
    await tester.pumpAndSettle();
  }

  testWidgets('capture screenshots', (tester) async {
    await tester.pumpWidget(const MyApp());
    await shot(tester, '01_login');

    await tester.tap(find.widgetWithText(TextButton, 'Register'));
    await shot(tester, '02_register');
    await back(tester);

    await tester.enterText(
      find.byType(TextFormField).at(0),
      'student@example.com',
    );
    await tester.enterText(find.byType(TextFormField).at(1), 'password');
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await shot(tester, '03_button_gallery');

    await tester.drag(find.byType(ListView), const Offset(0, -700));
    await shot(tester, '04_button_gallery_bottom');
    await tester.drag(find.byType(ListView), const Offset(0, 700));
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(ElevatedButton, 'Profile'));
    await shot(tester, '05_profile');
    await back(tester);

    await tester.tap(find.widgetWithText(FilledButton, 'Details'));
    await shot(tester, '06_details');
    await back(tester);

    await tester.tap(find.widgetWithText(FilledButton, 'Settings'));
    await shot(tester, '07_settings');
    await back(tester);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField), 'Study Flutter');
    await shot(tester, '08_add_item');
    await tester.tap(find.widgetWithText(FilledButton, 'Save'));
    await tester.pumpAndSettle();
    await tester.drag(find.byType(ListView), const Offset(0, -1200));
    await shot(tester, '09_item_added');
  });
}
