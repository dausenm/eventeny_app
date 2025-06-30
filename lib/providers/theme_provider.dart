import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/app_themes.dart';

enum AppTheme { light, dark, accessible }

final themeProvider = StateProvider<AppTheme>((ref) => AppTheme.light);

final themeDataProvider = Provider<ThemeData>((ref) {
  final currentTheme = ref.watch(themeProvider);
  switch (currentTheme) {
    case AppTheme.dark:
      return AppThemes.darkTheme;
    case AppTheme.accessible:
      return AppThemes.accessibleTheme;
    case AppTheme.light:
    default:
      return AppThemes.lightTheme;
  }
});
