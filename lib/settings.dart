import 'package:flutter/material.dart';
import 'package:misbaha_app/providers/db_provider.dart';
import 'package:misbaha_app/providers/tick_provider.dart';
import 'package:misbaha_app/ui/control_panel/vibration_slider_widget.dart';
import 'package:provider/provider.dart';

import 'custom_theme.dart';
import 'providers/app_provider.dart';
import 'providers/tasbih_daily_list_provider.dart';
import 'ui/tasbih_list/current_tasbih_list_widget.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = "Settings";
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
          backgroundColor: CustomTheme.bgColor,
        ),
        backgroundColor: CustomTheme.bgColor,
        body: Consumer<DBProvider>(
          builder: (context, dBProvider, ch) => ch,
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  VibrationSliderWidget(),
                  Expanded(child: CurrentTasbihList()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
