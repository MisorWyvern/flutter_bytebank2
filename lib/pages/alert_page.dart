import 'package:flutter/material.dart';

class AlertPage extends StatelessWidget {
  final String title;
  final String message;
  final String buttonText;
  final IconData icon;
  final Color iconColor;
  AlertPage({
    Key key,
    this.title = "Alert",
    this.message = "Error...",
    this.buttonText = "Ok",
    this.icon = Icons.warning,
    this.iconColor = Colors.redAccent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64,
              color: iconColor,
            ),
            Text(
              message,
              style: TextStyle(
                  fontSize:
                      Theme.of(context).textTheme.bodyText1.fontSize * 1.5,
                  color: Theme.of(context).textTheme.bodyText1.color),
              textAlign: TextAlign.center,
            ),
            RaisedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(buttonText.toUpperCase()),
            )
          ],
        ),
      ),
    );
  }
}
