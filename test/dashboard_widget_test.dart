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

  testWidgets("Should show the first feature when Dashboard opens",
      (WidgetTester widgetTester) async {
    await widgetTester.pumpWidget(
      MaterialApp(
        home: Dashboard(),
      ),
    );
    final firstFeature = find.byType(IconLabeledContainer);
    expect(firstFeature, findsWidgets);
  });
}
