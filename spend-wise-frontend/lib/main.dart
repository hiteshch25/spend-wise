import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/landing_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/dashboard_screen.dart';
import 'providers/theme_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'SpendWise',
          theme: themeProvider.isDarkMode ? ThemeData.dark() : ThemeData.light(),
          initialRoute: "/landing",
          routes: {
            "/landing": (context) => LandingScreen(),
            "/login": (context) => LoginScreen(),
            "/register": (context) => RegisterScreen(),
            "/dashboard": (context) => DashboardScreen(),
          },
        );
      },
    );
  }
}
