import 'package:flutter/material.dart';
import 'package:flutter_bytebank02/pages/dashboard.dart';
import 'package:flutter_test/flutter_test.dart';

import 'matchers.dart';

void main() {

  group("When Dashboard opens", (){
    testWidgets("Should show main image",
      (WidgetTester widgetTester) async {
    await widgetTester.pumpWidget(
      MaterialApp(
        home: Dashboard(),
      ),
    );
    final mainImage = find.byType(Image);
    expect(mainImage, findsOneWidget);
  });

  testWidgets("Should show transfer feature",
      (WidgetTester widgetTester) async {
    await widgetTester.pumpWidget(
      MaterialApp(
        home: Dashboard(),
      ),
    );
    final transferContainer =
        find.byWidgetPredicate((widget) => iconLabeledContainerMatcher(
              widget,
              "Transfer",
              Icons.monetization_on,
            ));
    expect(transferContainer, findsOneWidget);
  });

  testWidgets("Should show transaction feed feature",
      (WidgetTester widgetTester) async {
    await widgetTester.pumpWidget(MaterialApp(home: Dashboard()));
    final transactionFeedContainer =
        find.byWidgetPredicate((widget) => iconLabeledContainerMatcher(
              widget,
              "Transaction Feed",
              Icons.description,
            ));
    expect(transactionFeedContainer, findsOneWidget);
  });

  });
  
}


