import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:exam2/main.dart';

void main() {
  testWidgets('Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Verify that the app title is displayed
    expect(find.text('Form Validation'), findsOneWidget);

    // Verify the presence of input fields
    expect(find.byType(TextFormField), findsNWidgets(3));

    // Verify the presence of the Submit button
    expect(find.text('Submit Data'), findsOneWidget);
  });
}
