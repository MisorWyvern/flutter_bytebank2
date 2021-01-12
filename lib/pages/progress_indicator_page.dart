import 'package:flutter/material.dart';
import 'package:flutter_bytebank02/widgets/custom_progress_indicator.dart';

class ProgressIndicatorPage extends StatelessWidget {
  final String title;
  final String message;

  const ProgressIndicatorPage(
      {Key key, @required this.title, @required this.message})
      : assert(title != null),
        assert(message != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text(title),
      ),
      body: CustomProgressIndicator(message: message),
    );
  }
}
