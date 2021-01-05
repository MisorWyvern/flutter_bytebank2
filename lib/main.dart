import 'package:flutter/material.dart';

import 'package:flutter_bytebank02/database/dao/contact_dao.dart';
import 'package:flutter_bytebank02/http/webclients/transaction_webclient.dart';
import 'package:flutter_bytebank02/pages/dashboard.dart';
import 'package:flutter_bytebank02/widgets/app_dependencies.dart';

void main() {
  runApp(SecondByteBankApp(
    contactDAO: ContactDAO(),
    transactionWebClient: TransactionWebClient(),
  ));
}

class SecondByteBankApp extends StatelessWidget {
  final ContactDAO contactDAO;
  final TransactionWebClient transactionWebClient;

  const SecondByteBankApp({
    Key key,
    this.contactDAO,
    this.transactionWebClient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppDependencies(
      contactDAO: contactDAO,
      transactionWebClient: transactionWebClient,
      child: MaterialApp(
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
      ),
    );
  }
}
