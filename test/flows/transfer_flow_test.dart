import 'package:flutter/material.dart';
import 'package:flutter_bytebank02/main.dart';
import 'package:flutter_bytebank02/models/contact.dart';
import 'package:flutter_bytebank02/models/transaction.dart';
import 'package:flutter_bytebank02/pages/contact_list.dart';
import 'package:flutter_bytebank02/pages/dashboard_page.dart';
import 'package:flutter_bytebank02/pages/transaction_form.dart';
import 'package:flutter_bytebank02/widgets/response_dialog.dart';
import 'package:flutter_bytebank02/widgets/transaction_auth_dialog.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mocks/mocks.dart';
import 'events.dart';

void main() {
  testWidgets(
    "Should transfer to a contact",
    (WidgetTester widgetTester) async {
      final MockContactDAO mockContactDAO = MockContactDAO();
      final MockTransactionWebClient mockTransactionWebClient =
          MockTransactionWebClient();
      await widgetTester.pumpWidget(SecondByteBankApp(
        transactionWebClient: mockTransactionWebClient,
        contactDAO: mockContactDAO,
      ));

      final dashboard = find.byType(DashboardPage);
      expect(dashboard, findsOneWidget);

      final Contact testContact = Contact(0, 'Exemplo', 1000);
      when(mockContactDAO.findAll())
          .thenAnswer((realInvocation) async => [testContact]);

      //opens ContactList
      await tapOnTransferContainer(widgetTester);

      final contactsList = find.byType(ContactList);
      expect(contactsList, findsOneWidget);

      verify(mockContactDAO.findAll()).called(1);

      //opens TransactionForm
      await findAndTapContactListItem(widgetTester, "Exemplo", 1000);

      final transactionForm = find.byType(TransactionForm);
      expect(transactionForm, findsOneWidget);

      final contactName = find.text("Exemplo".toUpperCase());
      expect(contactName, findsOneWidget);
      final contactAccountNumber = find.text("1000");
      expect(contactAccountNumber, findsOneWidget);

      await findAndEnterTextOnTextField(widgetTester, "200", "Value",
          textFieldDescription: "Text Field Value");
      //opens TransactionAuthDialog
      await findAndTapRaisedButtonWithText(widgetTester, "Transfer");

      final transactionAuthDialog = find.byType(TransactionAuthDialog);
      expect(transactionAuthDialog, findsOneWidget);

      final textFieldPassword =
          find.byKey(transactionAuthDialogTextFieldPasswordKey);
      expect(textFieldPassword, findsOneWidget);

      when(mockTransactionWebClient.save(
              Transaction(null, 200, testContact), "1000"))
          .thenAnswer(
              (realInvocation) async => Transaction(null, 200, testContact));

      final cancelButton =
          find.widgetWithText(FlatButton, "Cancel".toUpperCase());
      expect(cancelButton, findsOneWidget);

      await widgetTester.enterText(textFieldPassword, "1000");
      await findAndTapFlatButtonWithText(widgetTester, "Confirm".toUpperCase());

      final successDialog = find.byType(SuccessDialog);
      expect(successDialog, findsOneWidget);

      await findAndTapFlatButtonWithText(widgetTester, "Ok".toUpperCase());

      final contactListBack = find.byType(ContactList);
      expect(contactListBack, findsOneWidget);
    },
  );
}
