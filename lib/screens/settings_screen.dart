import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/theme_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "App Theme",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          DropdownButton<AppTheme>(
            value: currentTheme,
            onChanged: (AppTheme? newTheme) {
              if (newTheme != null) {
                ref.read(themeProvider.notifier).state = newTheme;
              }
            },
            items:
                AppTheme.values.map((theme) {
                  final themeName =
                      theme.name[0].toUpperCase() + theme.name.substring(1);
                  return DropdownMenuItem(value: theme, child: Text(themeName));
                }).toList(),
          ),
        ],
      ),
    );
  }
}
