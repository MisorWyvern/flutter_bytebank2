import 'dart:convert';
import 'package:flutter_bytebank02/http/webclient.dart';
import 'package:http/http.dart';
import 'package:flutter_bytebank02/models/transaction.dart';

class TransactionWebClient {
  String _baseUrl = "http://192.168.1.108:8080/transactions";

  Future<List<Transaction>> findAll() async {
    final Response response = await client.get(_baseUrl);
    final List<dynamic> decodedJson = jsonDecode(response.body);

    final List<Transaction> transactions =
        decodedJson.map((e) => Transaction.fromJson(e)).toList();
    return transactions;
  }

  Future<Transaction> save(Transaction transaction, String password) async {
    final Map<String, dynamic> transactionMap = Transaction.toJson(transaction);
    final String transactionJson = jsonEncode(transactionMap);

    final Response response = await client.post(
      _baseUrl,
      headers: {
        'content-type': 'application/json',
        'password': password,
      },
      body: transactionJson,
    );

    if (statusCodeResponses.containsKey(response.statusCode) == true) {
      _throwHttpError(response.statusCode);
    }

    Map<String, dynamic> json = jsonDecode(response.body);
    return Transaction.fromJson(json);
  }

  void _throwHttpError(int statusCode) =>
      throw HttpException(statusCodeResponses[statusCode]);

  static final Map<int, String> statusCodeResponses = {
    400: "There was an error submitting a transaction...",
    401: "Authentication failed...",
  };
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);

  String toString() {
    String result = "HttpException";
    if (message != null) result = "$result: $message";
    return result;
  }
}
