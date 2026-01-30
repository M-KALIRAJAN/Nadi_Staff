import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider =
    NotifierProvider<ThemeNotifier, ThemeMode>(ThemeNotifier.new);

class ThemeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    return ThemeMode.light;
  }
  // ✅ ADD THIS
  void setTheme(bool isDark) {
    state = isDark ? ThemeMode.dark : ThemeMode.light;
  }
   // optional toggle
  void toggleTheme() {
    state =
        state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}
