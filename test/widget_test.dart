import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:newzly_app/main.dart';

void main() {
  testWidgets('App launches and shows splash screen',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that our app starts with the splash screen
    expect(find.text('Newzly'), findsOneWidget);
    expect(find.text('Berita Terupdate,'), findsOneWidget);
    expect(find.text('Setiap Saat'), findsOneWidget);
    expect(find.text('Mulai'), findsOneWidget);
  });

  testWidgets('Navigation to login screen works', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Find and tap the "Mulai" button
    await tester.tap(find.text('Mulai'));
    await tester.pumpAndSettle();

    // Verify that we navigated to login screen
    expect(find.text('Username'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Sign up'), findsOneWidget);
  });

  testWidgets('Login form validation', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Navigate to login screen
    await tester.tap(find.text('Mulai'));
    await tester.pumpAndSettle();

    // Find the username and password fields
    final usernameField = find.widgetWithText(TextField, 'Username');
    final passwordField = find.widgetWithText(TextField, 'Password');

    expect(usernameField, findsOneWidget);
    expect(passwordField, findsOneWidget);

    // Test entering text in fields
    await tester.enterText(usernameField, 'testuser');
    await tester.enterText(passwordField, 'testpass');

    expect(find.text('testuser'), findsOneWidget);
    expect(find.text('testpass'), findsOneWidget);
  });
}
