import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  AppTheme._();

  static final dartkTheme = ThemeData();

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    appBarTheme: ThemeData.light().appBarTheme.copyWith(
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
    backgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.grey[50],
    iconTheme: const IconThemeData(color: Colors.black),
    textTheme: _lightTextTheme,
  );
}

final _lightTextTheme = TextTheme(
  subtitle1: const TextStyle(fontWeight: FontWeight.bold)
      .merge(ThemeData.light().textTheme.subtitle1),
).merge(ThemeData.light().textTheme);
