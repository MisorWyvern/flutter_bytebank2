import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bytebank02/database/dao/contact_dao.dart';
import 'package:flutter_bytebank02/models/bloc_container.dart';
import 'package:flutter_bytebank02/models/contact.dart';
import 'package:flutter_bytebank02/models/cubits/contact_list_cubit.dart';
import 'package:flutter_bytebank02/pages/contact_form.dart';
import 'package:flutter_bytebank02/pages/transaction_form.dart';
import 'package:flutter_bytebank02/widgets/custom_progress_indicator.dart';

class ContactListContainer extends BlocContainer {
  @override
  Widget build(BuildContext context) {
    final ContactDAO dao = ContactDAO();
    return BlocProvider<ContactListCubit>(
      create: (BuildContext context) {
        final cubit = ContactListCubit();
        cubit.reload(dao);
        return cubit;
      },
      child: ContactList(dao),
    );
  }
}

@immutable
abstract class ContactListState {
  const ContactListState();
}

@immutable
class InitContactListState extends ContactListState {
  const InitContactListState();
}

@immutable
class LoadingContactListState extends ContactListState {
  const LoadingContactListState();
}

@immutable
class LoadedContactListState extends ContactListState {
  final List<Contact> _contactList;
  const LoadedContactListState(this._contactList)
      : assert(_contactList != null);
}

@immutable
class FatalErrorContactListState extends ContactListState {
  const FatalErrorContactListState();
}

class ContactList extends StatelessWidget {
  final ContactDAO _dao;

  const ContactList(this._dao, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final AppDependencies dependencies = AppDependencies.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text("Transfer"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ContactForm(),
            ),
          );
          update(context);
        },
        child: Icon(Icons.add),
      ),
      body: BlocBuilder<ContactListCubit, ContactListState>(
        builder: (BuildContext context, state) {
          if (state is InitContactListState ||
              state is LoadingContactListState) {
            return CustomProgressIndicator();
          }

          if (state is LoadedContactListState) {
            final List<Contact> contacts = state._contactList;
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
          }

          return const Text("Erro.");
        },
      ),
    );
  }

  void update(BuildContext context) {
    context.read<ContactListCubit>().reload(_dao);
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
