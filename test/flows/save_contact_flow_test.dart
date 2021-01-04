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
  testWidgets("Should save a contact", (WidgetTester widgetTester) async {
    final MockContactDAO mockContactDAO = MockContactDAO();
    await widgetTester.pumpWidget(SecondByteBankApp(
      contactDAO: mockContactDAO,
    ));

    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    //open ContactList
    await tapOnTransferContainer(widgetTester);

    final contactsList = find.byType(ContactList);
    expect(contactsList, findsOneWidget);

    verify(mockContactDAO.findAll()).called(1);

    final fabNewContact = find.widgetWithIcon(FloatingActionButton, Icons.add);
    expect(fabNewContact, findsOneWidget);

    //open add New Contact
    await widgetTester.tap(fabNewContact);
    await widgetTester.pumpAndSettle();

    final contactForm = find.byType(ContactForm);
    expect(contactForm, findsOneWidget);

    final nameTextField = find.byWidgetPredicate(
      (widget) =>
          widget is TextField && widget.decoration.labelText == "Full Name",
      description: "TextField Full Name",
    );
    expect(nameTextField, findsOneWidget);

    final accountNumberTextField = find.byWidgetPredicate(
      (widget) =>
          widget is TextField &&
          widget.decoration.labelText == "Account Number",
      description: "TextField AccountNumber",
    );
    expect(accountNumberTextField, findsOneWidget);

    await widgetTester.enterText(nameTextField, "Exemplo");
    await widgetTester.enterText(accountNumberTextField, "1234");

    var createButton =
        find.widgetWithText(RaisedButton, "Create".toUpperCase());
    expect(createButton, findsOneWidget);

    //saves contact and back to ContactList
    await widgetTester.tap(createButton);
    await widgetTester.pumpAndSettle();

    verify(mockContactDAO.save(Contact(0, "Exemplo", 1234)));
    verify(mockContactDAO.findAll()).called(1);

    final contactsListBack = find.byType(ContactList);
    expect(contactsListBack, findsOneWidget);
  });
}

