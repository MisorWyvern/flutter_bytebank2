import 'package:flutter/material.dart';
import 'package:flutter_bytebank02/pages/dashboard.dart';

void main() {
  runApp(SecondByteBankApp());
}

class SecondByteBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ByteBank',
      theme: ThemeData(
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
      ),
      home: Dashboard(),
    );
  }
}
