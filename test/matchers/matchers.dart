import 'package:flutter/material.dart';
import 'package:flutter_bytebank02/widgets/icon_labeled_container.dart';

bool iconLabeledContainerMatcher(Widget widget, String text, IconData icon) {
  if (widget is IconLabeledContainer) {
    return widget.text == text && widget.icon == icon;
  }
  return false;
}

bool textFieldByLabelTextMatcher(Widget widget, String labelText) {
  return widget is TextField && widget.decoration.labelText == labelText;
}
