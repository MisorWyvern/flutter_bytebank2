import 'dart:async';

import 'package:flutter_bytebank02/widgets/app_dependencies.dart';
import 'package:flutter_bytebank02/widgets/custom_progress_indicator.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bytebank02/http/webclients/transaction_webclient.dart';
import 'package:flutter_bytebank02/models/contact.dart';
import 'package:flutter_bytebank02/models/transaction.dart';
import 'package:flutter_bytebank02/widgets/response_dialog.dart';
import 'package:flutter_bytebank02/widgets/transaction_auth_dialog.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;

  TransactionForm(this.contact);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final String transactionId = Uuid().v4();

  bool _showProgressIndicator = false;

  @override
  Widget build(BuildContext context) {
    final AppDependencies dependencies = AppDependencies.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text('New transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                visible: _showProgressIndicator,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CustomProgressIndicator(
                      message: "Sending transaction..."),
                ),
              ),
              Text(
                widget.contact.name.toUpperCase(),
                style: TextStyle(
                  fontSize: 24.0,
                  color: Theme.of(context).textTheme.bodyText1.color,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contact.accountNumber.toString(),
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1.color,
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: TextStyle(fontSize: 24.0),
                  decoration: InputDecoration(labelText: 'Value'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: RaisedButton(
                    child: Text('Transfer'),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (dialogContext) {
                            return TransactionAuthDialog(
                              onConfirm: (password) {
                                final double value =
                                    double.tryParse(_valueController.text);
                                final transactionCreated = Transaction(
                                    transactionId, value, widget.contact);
                                _save(dependencies.transactionWebClient,
                                    transactionCreated, password, context);
                                Navigator.of(context).pop();
                              },
                            );
                          });
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _save(TransactionWebClient webClient, Transaction transaction,
      String password, BuildContext context) async {
    setState(() {
      _showProgressIndicator = true;
    });
    Transaction responseTransaction = await webClient
        .save(transaction, password)
        .catchError(
          (ex) => _showFailureDialog(context, message: ex.message),
          test: (e) => e is HttpException,
        )
        .catchError(
          (ex) => _showFailureDialog(context, message: "Connection timeout..."),
          test: (e) => e is TimeoutException,
        )
        .catchError(
          (ex) => _showFailureDialog(context),
          test: (e) => e is Exception,
        )
        .whenComplete(
          () => setState(() {
            _showProgressIndicator = false;
          }),
        );

    _showSuccessDialog(responseTransaction, context);
  }

  Future _showSuccessDialog(
      Transaction responseTransaction, BuildContext context) async {
    if (responseTransaction != null) {
      await showDialog(
          context: context,
          builder: (contextDialog) {
            return SuccessDialog("Transaction has succeeded!");
          });
      Navigator.of(context).pop();
    }
  }

  _showFailureDialog(BuildContext context,
      {String message = "Unknown error..."}) {
    showDialog(
        context: context,
        builder: (contextDialog) {
          return FailureDialog(message);
        });
  }
}
