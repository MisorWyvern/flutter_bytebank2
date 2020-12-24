import 'package:flutter/material.dart';

class IconLabeledContainer extends StatelessWidget {
  final String text;
  final IconData icon;

  const IconLabeledContainer(
      {Key key, @required this.text, @required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 100,
      width: 100 * 1.5,
      color: Theme.of(context).primaryColorDark,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Theme.of(context).textTheme.bodyText2.color,
          ),
          Text(
            text,
            style:
                TextStyle(color: Theme.of(context).textTheme.bodyText2.color),
          ),
        ],
      ),
    );
  }
}
