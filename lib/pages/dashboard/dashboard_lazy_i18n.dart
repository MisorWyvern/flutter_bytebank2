import 'package:flutter_bytebank02/models/i18n_messages.dart';

class DashboardPageLazyI18N {
  final I18NMessages _messages;
  DashboardPageLazyI18N(this._messages);

  String get transfer => _messages.get("transfer");

  String get transactionFeed => _messages.get("transaction_feed");

  String get changeName => _messages.get("change_name");
}
