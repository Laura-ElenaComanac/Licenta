import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:projyproject/main.dart' as app;
import 'package:projyproject/screens/intro_screen.dart';
import 'package:projyproject/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:projyproject/ui_screens/projyapp/generatedhomescreenwidget/GeneratedHomescreenWidget.dart';
import 'package:projyproject/ui_screens/projyapp/generatedloginscreenwidget/GeneratedLoginscreenWidget.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
      "Login screen -> complete Username, Password fields -> press Login Button -> Intro screen ",
      (WidgetTester tester) async {
    app.main();

    await tester.pump();
    expect(find.byType(GeneratedLoginscreenWidget), findsOneWidget);

    Finder usernameField = find.byKey(const Key('Username'));
    expect(usernameField, findsOneWidget);
    await tester.tap(usernameField);
    await tester.enterText(usernameField, 'audry');

    Finder passwordField = find.byKey(const Key('Password'));
    expect(passwordField, findsOneWidget);
    await tester.tap(passwordField);
    await tester.enterText(passwordField, 'audry');

    final loginButton = find.byKey(const Key('Login'));
    expect(loginButton, findsOneWidget);
    await tester.tap(loginButton);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(find.byType(GeneratedHomescreenWidget), findsOneWidget);
  });
}
