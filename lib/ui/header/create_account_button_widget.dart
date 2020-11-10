import 'package:flutter/material.dart';

import '../../custom_theme.dart';

class CreateAccountButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 7),
      decoration: BoxDecoration(
        color: CustomTheme.bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: <Widget>[
          Container(
            height: 34,
            width: 34,
            child: Image.asset(
              'assets/images/guest-male.png',
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            width: 2,
          ),
          Container(
            width: 100,
            child: Text(
              'Create account',
              style: TextStyle(color: Colors.white, wordSpacing: .5),
            ),
          )
        ],
      ),
    );
  }
}
