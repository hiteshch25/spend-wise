import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:cash_card_frontend/main.dart';
import 'package:cash_card_frontend/screens/register_screen.dart';
import 'package:cash_card_frontend/screens/login_screen.dart';
import 'package:cash_card_frontend/screens/dashboard_screen.dart';
import 'package:cash_card_frontend/providers/auth_provider.dart';

// Create a mock AuthProvider
class MockAuthProvider extends Mock implements AuthProvider {}

void main() {
  testWidgets('Registration screen renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: RegisterScreen()));

    expect(find.text('Parent Registration'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(3)); // Name, Email, Password fields
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('Login screen renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginScreen()));

    expect(find.text('Parent Login'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2)); // Email, Password fields
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('Dashboard screen loads and displays cards', (WidgetTester tester) async {
    final mockAuthProvider = MockAuthProvider();
    await tester.pumpWidget(
      ChangeNotifierProvider<AuthProvider>.value(
        value: mockAuthProvider,
        child: MaterialApp(home: DashboardScreen()),
      ),
    );

    expect(find.text('Family Cash Cards'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget); // Add Card button
  });
}
