import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/home_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/confirmation_screen.dart';
import 'screens/checkout_screen.dart';
import 'providers/theme_provider.dart';
import 'screens/settings_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeData = ref.watch(themeDataProvider);

    return MaterialApp(
      title: 'Eventeny App',
      theme: themeData,
      home: const HomeScreen(),
      routes: {
        '/cart': (context) => const CartScreen(),
        '/checkout': (context) => CheckoutScreen(),
        '/confirmation': (context) => const ConfirmationScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}
