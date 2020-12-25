import 'package:flutter/material.dart';
import 'package:flutter_bytebank02/pages/contact_list.dart';
import 'package:flutter_bytebank02/widgets/icon_labeled_container.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text("Dashboard"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("assets/images/bytebank_logo.png"),
            IconLabeledContainer(
              text: "Contacts",
              icon: Icons.people,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ContactList()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
