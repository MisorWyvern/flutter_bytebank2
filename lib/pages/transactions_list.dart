import 'package:flutter/material.dart';
import 'package:flutter_bytebank02/models/transaction.dart';
import 'package:flutter_bytebank02/widgets/centered_message.dart';
import 'package:flutter_bytebank02/widgets/custom_progress_indicator.dart';

import '../http/webclient.dart';
import '../models/transaction.dart';

class TransactionsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text('Transactions'),
      ),
      body: FutureBuilder<List<Transaction>>(
        future: findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return CustomProgressIndicator();
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.hasData == false) {
                return CenteredMessage("No data available.", icon: Icons.warning);
              }

              final List<Transaction> transactionsList = snapshot.data;

              if (transactionsList.isEmpty) {
                return CenteredMessage("No Transactions found",
                    icon: Icons.mood_bad);
              }

              return ListView.builder(
                itemCount: transactionsList.length,
                itemBuilder: (context, index) {
                  final Transaction transaction = transactionsList[index];
                  return Card(
                    child: ListTile(
                      leading: Icon(Icons.monetization_on),
                      title: Text(
                        transaction.value.toString(),
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        transaction.contact.accountNumber.toString(),
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  );
                },
              );
              break;
          }
          return CenteredMessage("Unknown Error!");
        },
      ),
    );
  }
}
