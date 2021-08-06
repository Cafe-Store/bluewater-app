import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final dartkTheme = ThemeData();

  static final lightTheme = ThemeData(
      appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
      scaffoldBackgroundColor: Colors.white);
}
