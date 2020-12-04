import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:misbaha_app/providers/db_provider.dart';
import 'package:misbaha_app/providers/tick_provider.dart';
import 'package:misbaha_app/services/db_service.dart';
import 'package:misbaha_app/utils/admob_flutter_service_.dart';
import 'package:misbaha_app/utils/helper.dart';
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

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation opacityAnimation;
  bool countProcessStarted1 = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: 200,
        ));
    opacityAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));
  }

  @override
  Widget build(BuildContext context) {
    AdsService adsService = GetIt.I.get<AdsService>();
    AppProvider appProvider = Provider.of<AppProvider>(context);
    appProvider.addListener(() async {
      if (appProvider.countProcessStarted) {
        countProcessStarted1 = await Helper.setValueAfterDelay(
            countProcessStarted1, appProvider.countProcessStarted, 1200);
        setState(() {
          controller.forward();
        });
      } else {
        countProcessStarted1 = await Helper.setValueAfterDelay(
            countProcessStarted1, appProvider.countProcessStarted, 1200);
        setState(() {
          controller.reverse();
        });
      }
    });
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
                                    height: CustomTheme.CircleWidgetHeight / 2 +
                                        10),
                                Expanded(
                                  child: Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 26),
                                      child: CurrentTasbihList(
                                        addTasbihHeaderOptional: true,
                                      )),
                                ),
                                countProcessStarted1
                                    ? FittedBox()
                                    : FadeTransition(
                                        opacity: opacityAnimation,
                                        child: AdmobBanner(
                                          adUnitId:
                                              adsService.getBannerAdUnitId(),
                                          adSize: adsService.bannerSize,
                                        ),
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
