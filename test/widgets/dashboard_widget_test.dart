import 'package:flutter/material.dart';
import 'package:flutter_bytebank02/database/dao/contact_dao.dart';
import 'package:flutter_bytebank02/pages/dashboard_page.dart';
import 'package:flutter_test/flutter_test.dart';

import '../matchers/matchers.dart';
import '../mocks/mocks.dart';

void main() {
  group(
    "When Dashboard opens",
    () {
      MockContactDAO mockContactDAO;
      // ignore: unused_element
      setUp() async {
        mockContactDAO = MockContactDAO();
      }

      testWidgets(
        "Should show main image",
        (WidgetTester widgetTester) async {
          await _pumpDashboard(widgetTester, mockContactDAO);
          final mainImage = find.byType(Image);
          expect(mainImage, findsOneWidget);
        },
      );

      testWidgets(
        "Should show transfer feature",
        (WidgetTester widgetTester) async {
          await _pumpDashboard(widgetTester, mockContactDAO);
          final transferContainer =
              find.byWidgetPredicate((widget) => iconLabeledContainerMatcher(
                    widget,
                    "Transfer",
                    Icons.monetization_on,
                  ));
          expect(transferContainer, findsOneWidget);
        },
      );

      testWidgets(
        "Should show transaction feed feature",
        (WidgetTester widgetTester) async {
          await _pumpDashboard(widgetTester, mockContactDAO);
          final transactionFeedContainer =
              find.byWidgetPredicate((widget) => iconLabeledContainerMatcher(
                    widget,
                    "Transaction Feed",
                    Icons.description,
                  ));
          expect(transactionFeedContainer, findsOneWidget);
        },
      );
    },
  );
}

Future _pumpDashboard(WidgetTester widgetTester, ContactDAO contactDAO) async {
  await widgetTester.pumpWidget(
    MaterialApp(
      home: DashboardPage(),
    ),
  );
}
