import 'package:flutter/material.dart';

ThemeData get appTheme => _mainTheme();

ThemeData _mainTheme() => ThemeData(
      colorScheme: const ColorScheme.light(),
      fontFamily: 'ProtestStrike',
      textTheme: _textTheme(),
    );

TextTheme _textTheme() {
  return const TextTheme(
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
    ),
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
    titleMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
    labelSmall: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w400,
    ),
  );
}
