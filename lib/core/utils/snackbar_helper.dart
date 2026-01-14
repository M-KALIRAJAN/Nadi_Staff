import 'package:flutter/material.dart';

class SnackbarHelper {
  static void show(
    BuildContext context, {
    String? message,
    required Color backgroundColor,
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message ?? "Something went wrong"),
          backgroundColor: backgroundColor,
          duration: duration,
        ),
      );
  }
}
