import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geotrivia/src/Forgot_Password/Forgot_Password_Screen.dart';

void main() {
  testWidgets('Testing', (WidgetTester tester) async {
    //find all widgets needed
    final addField = find.byKey(ValueKey('addField'));
    final addButton = find.byKey(ValueKey('addButton'));

    //execute the actual test
    await tester.pumpWidget(MaterialApp(home: ForgotPasswordScreen()));
    await tester.enterText(addField, "Widget Testing");
    await tester.tap(addButton);
    await tester.pump();

    //check outputs
    expect(find.text("Widget Testing"), findsOneWidget);
  });
}
