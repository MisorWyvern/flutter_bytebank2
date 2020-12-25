import 'package:flutter/material.dart';

class IconLabeledContainer extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function onTap;

  const IconLabeledContainer(
      {Key key, @required this.text, @required this.icon, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColorDark,
      child: InkWell(
        onTap: onTap != null ? onTap : () {},
        child: Container(
          padding: EdgeInsets.all(8),
          height: 100,
          width: 100 * 1.5,
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
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText2.color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
