import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:misbaha_app/providers/db_provider.dart';
import 'package:misbaha_app/providers/tick_provider.dart';
import 'package:misbaha_app/services/db_service.dart';
import './custom_theme.dart';
import './providers/app_provider.dart';
import './providers/tasbih_daily_list_provider.dart';
import './ui/control_panel/control_panel_widget.dart';
import './ui/header/upper_curved_container.dart';
import './ui/tasbih_list/current_tasbih_list_widget.dart';
import './ui/touch_panel/touch_panel_container.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  static const routeName = 'Home';
  @override
  _HomeState createState() => _HomeState();
}

DateTime currentBackPressTime;

Future<bool> _onWillPop(BuildContext ctx) async {
  AppProvider appProvider = Provider.of<AppProvider>(ctx, listen: false);
  if (appProvider.countProcessStarted) {
    TasbihDailyListProvider tasbihDailyListProvider =
        Provider.of<TasbihDailyListProvider>(ctx, listen: false);
    tasbihDailyListProvider.stopCounting();
    appProvider.stopCountProcess();
    return Future.value(false);
  } else {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
          msg: "Press double click to exit.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 12.0);
      return Future.value(false);
    }
    //   Navigator.of(ctx).pop();
    return Future.value(true);
  }
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Builder(
        builder: (context) => WillPopScope(
          onWillPop: () => _onWillPop(context),
          child: Scaffold(
            backgroundColor: CustomTheme.bgColor,
            body: Consumer<DBProvider>(
              builder: (context, dBProvider, ch) => ch,
              child: SafeArea(
                child: Container(
                  height: MediaQuery.of(context).size.height -
                      (MediaQuery.of(context).padding.bottom +
                          MediaQuery.of(context).padding.top),
                  child: Container(
                    //height: MediaQuery.of(context).size.height * .58,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                UpperCurvedContainer(),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * .45,
                                  margin: EdgeInsets.symmetric(horizontal: 28),
                                  child: CurrentTasbihList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        //   CircleButtonWidget(),
                        ControlPanelWidget(),
                        Positioned(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * .52,
                          bottom: 0,
                          //left: MediaQuery.of(context).size.width * 0.25,
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.only(
                                    bottom: 1, right: 30, left: 30),
                                child: TouchPanelContainer(),
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
          ),
        ),
      ),
    );
  }
}
