import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bytebank02/models/bloc_container.dart';
import 'package:flutter_bytebank02/models/contact.dart';
import 'package:flutter_bytebank02/models/cubits/transaction_form_cubit.dart';
import 'package:flutter_bytebank02/models/transaction.dart';
import 'package:flutter_bytebank02/pages/progress_indicator_page.dart';
import 'package:flutter_bytebank02/widgets/app_dependencies.dart';
import 'package:flutter_bytebank02/widgets/transaction_auth_dialog.dart';
import 'package:uuid/uuid.dart';

import 'alert_page.dart';

@immutable
abstract class TransactionFormState {
  const TransactionFormState();
}

@immutable
class SendingState extends TransactionFormState {
  const SendingState();
}

@immutable
class SentState extends TransactionFormState {
  const SentState();
}

@immutable
class ShowFormState extends TransactionFormState {
  const ShowFormState();
}

@immutable
class FatalErrorState extends TransactionFormState {
  final String message;
  const FatalErrorState(this.message);
}

class TransactionFormContainer extends BlocContainer {
  final Contact _contact;
  TransactionFormContainer(this._contact);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TransactionFormCubit>(
      create: (context) => TransactionFormCubit(),
      child: TransactionForm(_contact),
    );
  }
}

class TransactionForm extends StatelessWidget {
  final Contact contact;

  TransactionForm(this.contact);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionFormCubit, TransactionFormState>(
      builder: (context, state) {
        if (state is ShowFormState) {
          return _TransactionForm(contact);
        }

        if (state is SendingState) {
          return ProgressIndicatorPage(
              title: "New Transaction", message: "Sending Transaction...");
        }

        if (state is FatalErrorState) {
          return AlertPage(
            message: state.message,
          );
        }

        if (state is SentState) {
          return AlertPage(
            message: "Transaction has succeeded!",
            icon: Icons.check_circle_rounded,
            iconColor: Theme.of(context).primaryColor,
          );
        }

        return AlertPage(
          message: "Unknown Error...",
        );
      },
    );
  }
}

class _TransactionForm extends StatelessWidget {
  final Contact contact;

  _TransactionForm(this.contact);

  final TextEditingController _valueController = TextEditingController();
  final String transactionId = Uuid().v4();
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
              Text(
                contact.name.toUpperCase(),
                style: TextStyle(
                  fontSize: 24.0,
                  color: Theme.of(context).textTheme.bodyText1.color,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  contact.accountNumber.toString(),
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

                                try {
                                  final transactionCreated = Transaction(
                                      transactionId, value, contact);

                                  BlocProvider.of<TransactionFormCubit>(context)
                                      .save(
                                          dependencies.transactionWebClient,
                                          transactionCreated,
                                          password,
                                          context);
                                } catch (ex) {
                                  BlocProvider.of<TransactionFormCubit>(context)
                                      .throwError("Invalid Value");
                                } finally {
                                  Navigator.of(context).pop();
                                }
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
}
