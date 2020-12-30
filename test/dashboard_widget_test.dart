import 'package:flutter/material.dart';
import 'package:flutter_bytebank02/pages/dashboard.dart';
import 'package:flutter_bytebank02/widgets/icon_labeled_container.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Should show main image when Dashboard opens",
      (WidgetTester widgetTester) async {
    await widgetTester.pumpWidget(
      MaterialApp(
        home: Dashboard(),
      ),
    );
    final mainImage = find.byType(Image);
    expect(mainImage, findsOneWidget);
  });

  testWidgets("Should show transfer feature when Dashboard opens",
      (WidgetTester widgetTester) async {
    await widgetTester.pumpWidget(
      MaterialApp(
        home: Dashboard(),
      ),
    );
    final transferContainer =
        find.byWidgetPredicate((widget) => _iconLabeledContainerMatcher(
              widget,
              "Transfer",
              Icons.monetization_on,
            ));
    expect(transferContainer, findsOneWidget);
  });

  testWidgets("Should show transaction feed feature when Dashboard opens",
      (WidgetTester widgetTester) async {
    await widgetTester.pumpWidget(MaterialApp(home: Dashboard()));
    final transactionFeedContainer =
        find.byWidgetPredicate((widget) => _iconLabeledContainerMatcher(
              widget,
              "Transaction Feed",
              Icons.description,
            ));
    expect(transactionFeedContainer, findsOneWidget);
  });
}

bool _iconLabeledContainerMatcher(Widget widget, String text, IconData icon) {
  if (widget is IconLabeledContainer) {
    return widget.text == text && widget.icon == icon;
  }
  return false;
}
