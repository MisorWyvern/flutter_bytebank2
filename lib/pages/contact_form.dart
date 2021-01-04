import 'package:flutter/material.dart';
import 'package:flutter_bytebank02/database/dao/contact_dao.dart';
import 'package:flutter_bytebank02/models/contact.dart';

class ContactForm extends StatefulWidget {
  final ContactDAO contactDAO;

  const ContactForm({Key key, @required this.contactDAO}) : super(key: key);

  @override
  _ContactFormState createState() => _ContactFormState(contactDAO: contactDAO);
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();

  final ContactDAO contactDAO;
  _ContactFormState({this.contactDAO});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text("New contact"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Full Name",
              ),
              style: TextStyle(
                  fontSize: Theme.of(context).textTheme.headline5.fontSize),
            ),
            TextField(
              controller: _accountNumberController,
              decoration: InputDecoration(
                labelText: "Account Number",
              ),
              style: TextStyle(
                  fontSize: Theme.of(context).textTheme.headline5.fontSize),
              keyboardType: TextInputType.number,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: RaisedButton(
                  child: Text("Create".toUpperCase()),
                  onPressed: () {
                    final String name = _nameController.text;
                    final int accountNumber =
                        int.tryParse(_accountNumberController.text);

                    if (name == null || name == "" || accountNumber == null) {
                      return;
                    }

                    final Contact newContact = Contact(0, name, accountNumber);

                    _save(newContact, context);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _save(Contact newContact, BuildContext context) async {
    await contactDAO.save(newContact);
    Navigator.of(context).pop();
  }
}
