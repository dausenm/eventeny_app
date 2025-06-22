import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/home_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/confirmation_screen.dart';
import 'screens/checkout_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eventeny App',
      theme: ThemeData(
        primaryColor: Color(0xFF00C2C2),
        scaffoldBackgroundColor: Colors.grey[100],
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF00C2C2),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            textStyle: const TextStyle(fontSize: 16),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF00C2C2),
          foregroundColor: Colors.white,
          elevation: 4,
        ),
      ),
      home: const HomeScreen(),
      routes: {
        '/cart': (context) => const CartScreen(),
        '/checkout': (context) => CheckoutScreen(),
        '/confirmation': (context) => const ConfirmationScreen(),
      },
    );
  }
}
