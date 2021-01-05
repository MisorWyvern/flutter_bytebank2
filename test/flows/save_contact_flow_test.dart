import 'package:flutter/material.dart';
import 'package:flutter_bytebank02/main.dart';
import 'package:flutter_bytebank02/models/contact.dart';
import 'package:flutter_bytebank02/pages/contact_form.dart';
import 'package:flutter_bytebank02/pages/contact_list.dart';
import 'package:flutter_bytebank02/pages/dashboard.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mocks/mocks.dart';
import 'events.dart';

void main() {
  // ignore: unused_local_variable
  MockContactDAO mockContactDAO;
  MockTransactionWebClient mockTransactionWebClient;

  setUp(() async {
    mockContactDAO = MockContactDAO();
    mockTransactionWebClient = MockTransactionWebClient();
  });

  testWidgets("Should save a contact", (WidgetTester widgetTester) async {
    await widgetTester.pumpWidget(SecondByteBankApp(
      contactDAO: mockContactDAO,
      transactionWebClient: mockTransactionWebClient,
    ));

    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    //open ContactList
    await tapOnTransferContainer(widgetTester);

    final contactsList = find.byType(ContactList);
    expect(contactsList, findsOneWidget);

    verify(mockContactDAO.findAll()).called(1);

    await findAndtapOnFABWithIcon(widgetTester, Icons.add);

    final contactForm = find.byType(ContactForm);
    expect(contactForm, findsOneWidget);

    await findAndEnterTextOnTextField(widgetTester, "Exemplo", "Full Name",
        textFieldDescription: "TextField Full Name");
    await findAndEnterTextOnTextField(widgetTester, "1234", "Account Number",
        textFieldDescription: "TextField AccountNumber");

    await findAndTapRaisedButtonWithText(widgetTester, "Create".toUpperCase());

    verify(mockContactDAO.save(Contact(0, "Exemplo", 1234)));
    verify(mockContactDAO.findAll()).called(1);

    final contactsListBack = find.byType(ContactList);
    expect(contactsListBack, findsOneWidget);
  });
}
