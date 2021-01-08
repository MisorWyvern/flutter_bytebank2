import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bytebank02/models/cubits/name_cubit.dart';

class NamePage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _nameController.text = BlocProvider.of<NameCubit>(context).state;
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Name"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0 * 2),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Desired name"),
            ),
            RaisedButton(
              onPressed: () {
                String name = _nameController.text;
                if (name == null || name == "") return;

                context.read<NameCubit>().rename(name);
                Navigator.of(context).pop();
              },
              child: Text("Change Name".toUpperCase()),
            ),
          ],
        ),
      ),
    );
  }
}
