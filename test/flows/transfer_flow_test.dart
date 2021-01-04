import 'package:flutter/widgets.dart';
import 'package:flutter_bytebank02/main.dart';
import 'package:flutter_bytebank02/models/contact.dart';
import 'package:flutter_bytebank02/pages/contact_list.dart';
import 'package:flutter_bytebank02/pages/dashboard.dart';
import 'package:flutter_bytebank02/pages/transaction_form.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mocks/mocks.dart';
import 'events.dart';

void main() {
  testWidgets(
    "Should transfer to a contact",
    (WidgetTester widgetTester) async {
      final MockContactDAO mockContactDAO = MockContactDAO();
      await widgetTester.pumpWidget(SecondByteBankApp(
        contactDAO: mockContactDAO,
      ));

      final dashboard = find.byType(Dashboard);
      expect(dashboard, findsOneWidget);

      when(mockContactDAO.findAll())
        ..thenAnswer(
          (realInvocation) async {
            debugPrint("Name invocation ${realInvocation.memberName}");
            return [Contact(0, 'Exemplo', 1000)];
          },
        );

      //open ContactList
      await tapOnTransferContainer(widgetTester);

      final contactsList = find.byType(ContactList);
      expect(contactsList, findsOneWidget);

      verify(mockContactDAO.findAll()).called(1);

      final contactItem = find.byWidgetPredicate((widget) =>
          widget is ContactListItem &&
          widget.contact.name == "Exemplo" &&
          widget.contact.accountNumber == 1000);

      expect(contactItem, findsOneWidget);


      //open TransactionForm
      await widgetTester.tap(contactItem);
      await widgetTester.pumpAndSettle();
      final transactionForm = find.byType(TransactionForm);
      expect(transactionForm, findsOneWidget);

    },
  );
}
