import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bytebank02/models/bloc_container.dart';
import 'package:flutter_bytebank02/models/cubits/name_cubit.dart';
import 'package:flutter_bytebank02/pages/contact_list.dart';
import 'package:flutter_bytebank02/pages/transactions_list.dart';
import 'package:flutter_bytebank02/widgets/icon_labeled_container.dart';

import 'name_page.dart';

class DashboardContainer extends BlocContainer {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NameCubit("Exemplo"),
      child: Dashboard(),
    );
  }
}

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String name = BlocProvider.of<NameCubit>(context, listen: true).state;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text("Welcome $name"),
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
                            _showContactListPage(context);
                          },
                        ),
                        IconLabeledContainer(
                          text: "Transaction Feed",
                          icon: Icons.description,
                          onTap: () {
                            _showTransactionListPage(context);
                          },
                        ),
                        IconLabeledContainer(
                          text: "Change Name",
                          icon: Icons.person_outline,
                          onTap: () {
                            _showNamePage(context);
                          },
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

  void _showNamePage(BuildContext blocContext) {
    Navigator.of(blocContext).push(
      MaterialPageRoute(
        builder: (context) {
          return BlocProvider.value(
            value: BlocProvider.of<NameCubit>(blocContext),
            child: NamePage(),
          );
        },
      ),
    );
  }

  void _showContactListPage(BuildContext blocContext) {
    push(blocContext, ContactListContainer());
  }

  void _showTransactionListPage(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => TransactionsList()));
  }
}
