import 'package:flutter/material.dart';
import 'package:flutter_bytebank02/pages/contact_form.dart';

class ContactList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text("Contacts"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ContactForm()))
              .then((newContact) => debugPrint(newContact));
        },
        child: Icon(Icons.add),
      ),
      body: ListView(
        children: [
          Card(
            child: ListTile(
              title: Text(
                "Nome",
                style: TextStyle(
                    fontSize: Theme.of(context).textTheme.headline5.fontSize),
              ),
              subtitle: Text(
                "0000",
                style: TextStyle(
                    fontSize: Theme.of(context).textTheme.headline6.fontSize),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
