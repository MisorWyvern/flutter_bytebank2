import 'package:flutter/material.dart';
import 'package:flutter_bytebank02/database/dao/contact_dao.dart';
import 'package:flutter_bytebank02/pages/contact_list.dart';
import 'package:flutter_bytebank02/pages/transactions_list.dart';
import 'package:flutter_bytebank02/widgets/icon_labeled_container.dart';

class Dashboard extends StatelessWidget {
  final ContactDAO contactDAO;
  Dashboard({@required this.contactDAO});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text("Dashboard"),
      ),
      body: LayoutBuilder(
        builder: (context, viewportConstraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: viewportConstraints.maxHeight),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset("assets/images/bytebank_logo.png"),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        IconLabeledContainer(
                          text: "Transfer",
                          icon: Icons.monetization_on,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => ContactList(contactDAO: contactDAO,)),
                            );
                          },
                        ),
                        IconLabeledContainer(
                          text: "Transaction Feed",
                          icon: Icons.description,
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => TransactionsList()));
                          },
                        ),
                        IconLabeledContainer(
                          text: "Placeholder Container",
                          icon: Icons.battery_alert,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
