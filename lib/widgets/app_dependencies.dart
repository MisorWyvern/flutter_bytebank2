import 'package:flutter/cupertino.dart';

import 'package:flutter_bytebank02/database/dao/contact_dao.dart';
import 'package:flutter_bytebank02/http/webclients/transaction_webclient.dart';

class AppDependencies extends InheritedWidget {
  final ContactDAO contactDAO;
  final TransactionWebClient transactionWebClient;
  final Widget child;

  AppDependencies({
    Key key,
    @required this.contactDAO,
    @required this.transactionWebClient,
    @required this.child,
  })  : assert(contactDAO != null),
        assert(transactionWebClient != null),
        assert(child != null),
        super(key: key, child: child);

  static AppDependencies of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppDependencies>();

  @override
  bool updateShouldNotify(AppDependencies oldWidget) =>
      contactDAO != oldWidget.contactDAO ||
      transactionWebClient != oldWidget.transactionWebClient;
}
