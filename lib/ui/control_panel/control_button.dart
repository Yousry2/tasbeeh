import 'package:flutter/material.dart';

import '../../custom_theme.dart';

class ControlButton extends StatelessWidget {
  final Color color;
  final Function onPress;
  final IconData icon;
  final String text;

  ControlButton({
    @required this.text,
    @required this.color,
    @required this.icon,
    @required this.onPress,
  }) {}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ClipOval(
          child: InkWell(
            borderRadius: BorderRadius.circular(40),
            child: Container(
              width: 60,
              height: 60,
              child: Icon(
                icon,
                color: CustomTheme.color1,
                size: 25,
              ),
              color: color,
            ),
            onTap: onPress,
          ),
        ),
        Container(
          width: 50,
          height: 20,
          child: Text(
            text,
            textAlign: TextAlign.center,
            softWrap: false,
            overflow: TextOverflow.clip,
            style: TextStyle(color: CustomTheme.color1),
          ),
        ),
      ],
    );
  }
}
