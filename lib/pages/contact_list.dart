import 'package:flutter/material.dart';
import 'package:flutter_bytebank02/models/contact.dart';
import 'package:flutter_bytebank02/pages/contact_form.dart';
import 'package:flutter_bytebank02/pages/transaction_form.dart';
import 'package:flutter_bytebank02/widgets/app_dependencies.dart';
import 'package:flutter_bytebank02/widgets/custom_progress_indicator.dart';

class ContactList extends StatefulWidget {
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  @override
  Widget build(BuildContext context) {
    final AppDependencies dependencies = AppDependencies.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text("Transfer"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                builder: (context) => ContactForm(),
              ))
              .then((value) => setState(() {}));
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder<List<Contact>>(
          initialData: [],
          future: dependencies.contactDAO.findAll(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                return CustomProgressIndicator();
                break;
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                final List<Contact> contacts = snapshot.data;
                return ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (context, index) {
                    return ContactListItem(
                      contact: contacts[index],
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return TransactionForm(contacts[index]);
                        }));
                      },
                    );
                  },
                );
                break;
            }
            return Text("Erro.");
          }),
    );
  }
}

class ContactListItem extends StatelessWidget {
  final Contact contact;
  final Function onTap;

  const ContactListItem({Key key, @required this.contact, @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: Icon(Icons.person),
        title: Text(
          contact.name,
          style: TextStyle(
              fontSize: Theme.of(context).textTheme.headline5.fontSize),
        ),
        subtitle: Text(
          contact.accountNumber.toString(),
          style: TextStyle(
              fontSize: Theme.of(context).textTheme.headline6.fontSize),
        ),
      ),
    );
  }
}
