import 'package:flutter/material.dart';

final ThemeData themeData = ThemeData(
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: Colors.orangeAccent,
    secondary: Colors.black87,
    background: Colors.grey[400],
  ),
  appBarTheme: const AppBarTheme(
    titleTextStyle: TextStyle(
      color: Colors.black87,
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
    color: Colors.transparent,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black87),
  ),
);
