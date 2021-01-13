import 'dart:convert';

import 'package:http/http.dart';

import '../webclient.dart';

class I18NWebClient {
  static const String messagesURI =
      "https://gist.githubusercontent.com/MisorWyvern/dad54753818cbe511d5f33ca11144d9c/raw/7a9efda640661c4fe31ee5fa5abd1926840dd603/";

  final String _pageKey;

  I18NWebClient(this._pageKey);

  Future<Map<String, dynamic>> findAll() async {
    final Response response = await client.get("$messagesURI$_pageKey");
    final Map<String, dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson;
  }
}
