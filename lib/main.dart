import 'package:flutter/material.dart';
import 'package:flutter_bytebank02/database/dao/contact_dao.dart';
import 'package:flutter_bytebank02/pages/dashboard.dart';

void main() {
  runApp(SecondByteBankApp(contactDAO: ContactDAO(),));
}

class SecondByteBankApp extends StatelessWidget {
  final ContactDAO contactDAO;

  const SecondByteBankApp({Key key, @required this.contactDAO}) : super(key: key);

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
      home: Dashboard(
        contactDAO: contactDAO,
      ),
    );
  }
}
