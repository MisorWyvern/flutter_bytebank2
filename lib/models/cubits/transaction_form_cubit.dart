import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bytebank02/http/webclients/transaction_webclient.dart';
import 'package:flutter_bytebank02/models/transaction.dart';
import 'package:flutter_bytebank02/pages/transaction_form.dart';

class TransactionFormCubit extends Cubit<TransactionFormState> {
  TransactionFormCubit() : super(ShowFormState());

  Future<void> save(TransactionWebClient webClient, Transaction transaction,
      String password, BuildContext context) async {
    emit(SendingState());
    Transaction responseTransaction = await webClient
        .save(transaction, password)
        .catchError(
          (ex) => throwError(ex.message),
          test: (e) => e is HttpException,
        )
        .catchError(
          (ex) => throwError("Connection timeout..."),
          test: (e) => e is TimeoutException,
        )
        .catchError(
          (ex) => throwError(ex.message),
          test: (e) => e is Exception,
        );
    if (responseTransaction != null) {
      debugPrint("Response Transaction: $responseTransaction");
      emit(SentState());
    }
  }

  throwError(String message) {
    emit(FatalErrorState(message));
  }
}
