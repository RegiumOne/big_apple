import 'package:flutter/material.dart';

ThemeData get appTheme => _mainTheme();

ThemeData _mainTheme() => ThemeData(
      colorScheme: const ColorScheme.light(),
      fontFamily: 'ProtestStrike',
      textTheme: _textTheme(),
    );

TextTheme _textTheme() {
  return const TextTheme(
    bodyMedium: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
    ),
  );
}
