import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    hintColor: Colors.black45,
    scaffoldBackgroundColor: Colors.grey[200],
    textTheme: TextTheme(
      bodySmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.black45,
        fontFamily: 'flutterfonts',
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black45,
        fontFamily: 'flutterfonts',
      ),
      bodyLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black45,
        fontFamily: 'flutterfonts',
      ),
    ),
    iconTheme: IconThemeData(
      color: Colors.black45,
    ));
