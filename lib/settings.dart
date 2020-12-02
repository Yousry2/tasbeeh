import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:misbaha_app/providers/db_provider.dart';
import 'package:misbaha_app/providers/tick_provider.dart';
import 'package:misbaha_app/ui/control_panel/vibration_slider_widget.dart';
import 'package:misbaha_app/utils/admob_flutter_service_.dart';
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
    AdsService adsService = GetIt.I.get<AdsService>();

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
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: VibrationSliderWidget()),
                  Expanded(child: CurrentTasbihList()),
                  AdmobBanner(
                    adUnitId: adsService.getBanner2AdUnitId(),
                    adSize: adsService.banner2Size,
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
