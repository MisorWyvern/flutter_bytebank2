import 'package:flutter/material.dart';

class TransactionAuthDialog extends StatefulWidget {
  final Function(String) onConfirm;

  const TransactionAuthDialog({Key key, this.onConfirm}) : super(key: key);

  @override
  _TransactionAuthDialogState createState() => _TransactionAuthDialogState();
}

class _TransactionAuthDialogState extends State<TransactionAuthDialog> {
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Authenticate"),
      content: TextField(
        controller: _passwordController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
        obscureText: true,
        maxLength: 4,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        style: TextStyle(fontSize: 64, letterSpacing: 16),
      ),
      actions: [
        FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text("Cancel".toUpperCase()),
        ),
        FlatButton(
          onPressed: () {
            widget.onConfirm(_passwordController.text);
            // Navigator.of(context).pop();
          },
          child: Text("Confirm".toUpperCase()),
        ),
      ],
    );
  }
}
