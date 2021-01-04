import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../matchers/matchers.dart';

Future tapOnTransferContainer(WidgetTester widgetTester) async {
   final transferContainer = find.byWidgetPredicate((widget) =>
      iconLabeledContainerMatcher(widget, "Transfer", Icons.monetization_on));
  
  expect(transferContainer, findsOneWidget);
  
  await widgetTester.tap(transferContainer);
  await widgetTester.pumpAndSettle();
}
