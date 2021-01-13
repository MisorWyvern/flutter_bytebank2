import 'package:flutter/cupertino.dart';
import 'package:flutter_bytebank02/widgets/localization/eager_localization.dart';

class DashboardPageEagerI18N extends PageI18N {
  DashboardPageEagerI18N(BuildContext context) : super(context);

  String get transfer => localize({
        "pt-br": "Transferência",
        "en-us": "Transfer",
      });
  String get transactionFeed => localize({
        "pt-br": "Transações",
        "en-us": "Transaction Feed",
      });
  String get changeName => localize({
        "pt-br": "Alterar Nome",
        "en-us": "Change Name",
      });
}
