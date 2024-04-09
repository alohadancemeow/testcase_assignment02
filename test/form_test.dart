import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:exam2/main.dart';

void main() {
  const fullname = 'John Doe';
  const phoneNumber = '1234567890';
  const email = 'john.doe@example.com';

  group('Form Validation', () {
    testWidgets('Empty form validation', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Ensure the Submit button is displayed
      expect(find.text('Submit Data'), findsOneWidget);

      // Tap the Submit button and trigger validation
      await tester.tap(find.text('Submit Data'));
      await tester.pump();

      // Ensure that error messages are displayed for all fields
      expect(find.text('Enter Correct Name'), findsOneWidget);
      expect(find.text('Enter Correct Phone Number'), findsOneWidget);
      expect(find.text('Enter Correct Email Address'), findsOneWidget);
    });

    testWidgets('Valid form submission', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Find the text fields by their labels
      final nameField = find.bySemanticsLabel('Enter Name');
      final phoneField = find.bySemanticsLabel('Enter Phone Number');
      final emailField = find.bySemanticsLabel('Enter Email');

      // Enter invalid data into each text field
      await tester.enterText(nameField, '123');
      await tester.enterText(phoneField, '12345');
      await tester.enterText(emailField, 'invalid_email');

      // Trigger validation by tapping the Submit button
      await tester.tap(find.text('Submit Data'));
      await tester.pump();

      // Verify that error messages are displayed for each field
      expect(find.text('Enter Correct Name'), findsOneWidget);
      expect(find.text('Enter Correct Phone Number'), findsOneWidget);
      expect(find.text('Enter Correct Email Address'), findsOneWidget);

      // Enter valid data into each text field
      await tester.enterText(nameField, fullname);
      await tester.enterText(phoneField, phoneNumber);
      await tester.enterText(emailField, email);

      // Trigger validation again by tapping the Submit button
      await tester.tap(find.text('Submit Data'));
      await tester.pump();

      // Verify that no error messages are displayed
      expect(find.text('Enter Correct Name'), findsNothing);
      expect(find.text('Enter Correct Phone Number'), findsNothing);
      expect(find.text('Enter Correct Email Address'), findsNothing);
    });

    testWidgets('Data Display Dialog Test', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Find the text fields by their labels
      final nameField = find.bySemanticsLabel('Enter Name');
      final phoneField = find.bySemanticsLabel('Enter Phone Number');
      final emailField = find.bySemanticsLabel('Enter Email');

      // Enter valid data into each text field
      await tester.enterText(nameField, fullname);
      await tester.enterText(phoneField, phoneNumber);
      await tester.enterText(emailField, email);

      // Tap the Submit button and trigger validation
      await tester.tap(find.text('Submit Data'));
      await tester.pump();

      // Verify that the data display dialog is shown
      expect(find.byType(AlertDialog), findsOneWidget);

      // Verify that the user's information is displayed correctly in the dialog
      // descendant = widget inside the AlertDialog
      expect(
          find.descendant(
            of: find.byType(AlertDialog),
            matching: find.text(fullname),
          ),
          findsOneWidget);
      expect(
          find.descendant(
            of: find.byType(AlertDialog),
            matching: find.text(phoneNumber),
          ),
          findsOneWidget);
      expect(
          find.descendant(
            of: find.byType(AlertDialog),
            matching: find.text(email),
          ),
          findsOneWidget);
    });
  });
}
