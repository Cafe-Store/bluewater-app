import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final dartkTheme = ThemeData();

  static final lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
    ),
    scaffoldBackgroundColor: Colors.grey[50],
    iconTheme: const IconThemeData(color: Colors.black),
    textTheme: _TextTheme.lightTextTheme,
  );
}

class _TextTheme {
  static final lightTextTheme = TextTheme(
    subtitle1: const TextStyle(fontWeight: FontWeight.bold)
        .merge(ThemeData.light().textTheme.subtitle1),
  ).merge(ThemeData.light().textTheme);
}
