import 'package:flutter/material.dart';
import 'package:flutter_bytebank02/pages/contact_list.dart';
import 'package:flutter_test/flutter_test.dart';

import '../matchers/matchers.dart';

Future tapOnTransferContainer(WidgetTester widgetTester) async {
  final transferContainer = find.byWidgetPredicate((widget) =>
      iconLabeledContainerMatcher(widget, "Transfer", Icons.monetization_on));

  expect(transferContainer, findsOneWidget);

  await widgetTester.tap(transferContainer);
  await widgetTester.pumpAndSettle();
}

Future findAndTapRaisedButtonWithText(
    WidgetTester widgetTester, String text) async {
  var raisedButton = find.widgetWithText(RaisedButton, text);
  expect(raisedButton, findsOneWidget);

  //saves contact and back to ContactList
  await widgetTester.tap(raisedButton);
  await widgetTester.pumpAndSettle();
}

Future findAndTapFlatButtonWithText(
    WidgetTester widgetTester, String text) async {
  var flatButton = find.widgetWithText(FlatButton, text);
  expect(flatButton, findsOneWidget);

  //saves contact and back to ContactList
  await widgetTester.tap(flatButton);
  await widgetTester.pumpAndSettle();
}

Future findAndEnterTextOnTextField(
    WidgetTester widgetTester, String text, String textFieldLabel,
    {String textFieldDescription}) async {
  final textField = find.byWidgetPredicate(
    (widget) =>
        widget is TextField && widget.decoration.labelText == textFieldLabel,
    description: textFieldDescription,
  );
  expect(textField, findsOneWidget);
  await widgetTester.enterText(textField, text);
}

Future findAndtapOnFABWithIcon(WidgetTester widgetTester, IconData icon) async {
  final fab = find.widgetWithIcon(FloatingActionButton, icon);
  expect(fab, findsOneWidget);

  //open add New Contact
  await widgetTester.tap(fab);
  await widgetTester.pumpAndSettle();
}

Future findAndTapContactListItem(
    WidgetTester widgetTester, String contactName, int accountNumber) async {
  final contactItem = find.byWidgetPredicate((widget) =>
      widget is ContactListItem &&
      widget.contact.name == contactName &&
      widget.contact.accountNumber == accountNumber);

  expect(contactItem, findsOneWidget);

  //open TransactionForm
  await widgetTester.tap(contactItem);
  await widgetTester.pumpAndSettle();
}
