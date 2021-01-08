import 'package:flutter/material.dart';
import 'package:flutter_bytebank02/database/dao/contact_dao.dart';
import 'package:flutter_bytebank02/http/webclients/transaction_webclient.dart';
import 'package:flutter_bytebank02/pages/dashboard.dart';
import 'package:flutter_bytebank02/widgets/app_dependencies.dart';
import 'package:flutter_bytebank02/widgets/theme.dart';

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
        theme: baitBankTheme,
        home: DashboardContainer(),
      ),
    );
  }
}
