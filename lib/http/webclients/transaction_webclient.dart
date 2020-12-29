import 'dart:convert';
import 'package:flutter_bytebank02/http/webclient.dart';
import 'package:http/http.dart';
import 'package:flutter_bytebank02/models/transaction.dart';

class TransactionWebClient {
  String _baseUrl = "http://192.168.1.108:8080/transactions";

  Future<List<Transaction>> findAll() async {
    final Response response =
        await client.get(_baseUrl).timeout(Duration(seconds: 5));
    final List<dynamic> decodedJson = jsonDecode(response.body);

    final List<Transaction> transactions =
        decodedJson.map((e) => Transaction.fromJson(e)).toList();
    return transactions;
  }

  Future<Transaction> save(Transaction transaction) async {
    final Map<String, dynamic> transactionMap = Transaction.toJson(transaction);
    final String transactionJson = jsonEncode(transactionMap);

    final Response response = await client.post(
      _baseUrl,
      headers: {'content-type': 'application/json', 'password': '1000'},
      body: transactionJson,
    );

    Map<String, dynamic> json = jsonDecode(response.body);
    return Transaction.fromJson(json);
  }
}
