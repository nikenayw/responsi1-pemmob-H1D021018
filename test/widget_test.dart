import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:manaj_keuangan_app/main.dart';

void main() {
  testWidgets('Login screen test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp()); // Menghapus 'const'

    // Verify that the login screen is displayed.
    expect(find.text('Login'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2)); // Assuming 2 TextFields for email and password

    // Enter email and password.
    await tester.enterText(find.byType(TextField).first, 'test@example.com');
    await tester.enterText(find.byType(TextField).last, 'password123');

    // Tap the login button.
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle(); // Wait for animations to finish

    // Verify that the expense screen is displayed (change this based on your implementation).
    expect(find.text('Pengeluaran'), findsOneWidget);
  });
}
