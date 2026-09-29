import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:l5_rupan_a2/main.dart';

Future<void> login(WidgetTester tester) async {
  await tester.enterText(
    find.byType(TextFormField).at(0),
    'student@example.com',
  );
  await tester.enterText(find.byType(TextFormField).at(1), 'password');
  await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('Login shows errors for empty fields', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pump();

    expect(find.text('Email is required'), findsOneWidget);
    expect(find.text('Password is required'), findsOneWidget);
  });

  testWidgets('Login uses pushReplacement: no way back to Login', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await login(tester);

    expect(find.text('Button Gallery'), findsOneWidget);
    final navigator = tester.state<NavigatorState>(find.byType(Navigator));
    expect(navigator.canPop(), isFalse);
  });

  testWidgets('push() to Profile and pop() back to the gallery', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await login(tester);

    await tester.tap(find.widgetWithText(ElevatedButton, 'Profile'));
    await tester.pumpAndSettle();
    expect(find.text('student@example.com'), findsOneWidget);

    await tester.tap(find.widgetWithText(OutlinedButton, 'Back'));
    await tester.pumpAndSettle();
    expect(find.text('Button Gallery'), findsOneWidget);
  });

  testWidgets('Named route opens Details with arguments', (tester) async {
    await tester.pumpWidget(const MyApp());
    await login(tester);

    await tester.tap(find.widgetWithText(FilledButton, 'Details'));
    await tester.pumpAndSettle();
    expect(find.text('The Navigation Stack'), findsOneWidget);
    expect(find.text('FilledButton in the Button Gallery'), findsOneWidget);
  });

  testWidgets('Add screen returns a value with pop()', (tester) async {
    await tester.pumpWidget(const MyApp());
    await login(tester);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField), 'Buy milk');
    await tester.tap(find.widgetWithText(FilledButton, 'Save'));
    await tester.pumpAndSettle();

    expect(find.text('Added "Buy milk"'), findsOneWidget);
  });

  testWidgets('Logout replaces the gallery with Login', (tester) async {
    await tester.pumpWidget(const MyApp());
    await login(tester);

    await tester.scrollUntilVisible(find.text('Logout'), 300);
    await tester.tap(find.text('Logout'));
    await tester.pumpAndSettle();

    expect(find.text('Welcome back'), findsOneWidget);
    final navigator = tester.state<NavigatorState>(find.byType(Navigator));
    expect(navigator.canPop(), isFalse);
  });
}
