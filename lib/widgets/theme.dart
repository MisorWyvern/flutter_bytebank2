import 'package:flutter/material.dart';

final baitBankTheme = ThemeData(
  primarySwatch: Colors.green,
  accentColor: Colors.blueAccent[700],
  primaryColorDark: Colors.green[900],
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.blueAccent[700],
    textTheme: ButtonTextTheme.primary,
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: TextTheme(
    bodyText1: TextStyle(
      color: Colors.black,
    ),
    bodyText2: TextStyle(
      color: Colors.white,
    ),
    headline5: TextStyle(fontSize: 24),
    headline6: TextStyle(fontSize: 16),
  ),
);
