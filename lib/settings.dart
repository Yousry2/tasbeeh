import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:measured_size/measured_size.dart';
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

class _SettingsScreenState extends State<SettingsScreen>
    with SingleTickerProviderStateMixin {
  AdsService adsService = GetIt.I.get<AdsService>();
  Size adAvaliableSize = Size.infinite;
  bool adShown = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(milliseconds: 100), () {
        if (!adShown) {
          setState(() {
            adShown = true;
          });
        }
      });
    });
  }

  Widget expandedAd() => Container(
        child: adAvaliableSize?.height >= adsService.banner4Size.height
            ? AdmobBanner(
                adUnitId: adsService.getBanner4AdUnitId(),
                adSize: adsService.banner4Size,
                listener: (AdmobAdEvent event, Map<String, dynamic> args) {
                  adsService.handleEvent(event, args, 'Banner');
                })
            : AdmobBanner(
                adUnitId: adsService.getBanner5AdUnitId(),
                adSize: adsService.banner5Size,
                listener: (AdmobAdEvent event, Map<String, dynamic> args) {
                  adsService.handleEvent(event, args, 'Banner');
                }),
      );

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
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: VibrationSliderWidget()),
                  adShown
                      ? Expanded(
                          child: Container(
                            //  height: 5000,
                            // constraints: BoxConstraints(
                            //   minHeight: 300,
                            // ),
                            child: CurrentTasbihList(),
                          ),
                        )
                      : Container(
                          height: 250,
                          // constraints: BoxConstraints(
                          //   minHeight: 300,
                          // ),
                          child: CurrentTasbihList(),
                        ),
                  MeasuredSize(
                    onChange: (Size size) {
                      setState(() {
                        if (!adShown) adAvaliableSize = size;
                      });
                    },
                    child: adShown
                        ? Container(
                            child: expandedAd(),
                          )
                        : Expanded(
                            child: expandedAd(),
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
