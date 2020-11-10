import 'package:flutter/material.dart';
import 'package:misbaha_app/settings.dart';
import '../../custom_theme.dart';

class SettingsButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(SettingsScreen.routeName),
      child: Container(
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
              child: Icon(
                Icons.tune,
                color: CustomTheme.mainTxtColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
