import 'package:admob_flutter/admob_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:measured_size/measured_size.dart';
import 'package:misbaha_app/ui/control_panel/control_buttons_widget.dart';
import 'package:misbaha_app/ui/control_panel/speed_slider_widget.dart';
import 'package:misbaha_app/ui/control_panel/vibration_slider_widget.dart';
import 'package:misbaha_app/utils/admob_flutter_service_.dart';
import 'package:provider/provider.dart';

import './control_button.dart';
import './start_button_widget.dart';
import '../../custom_theme.dart';
import '../../providers/app_provider.dart';
import '../../providers/tasbih_daily_list_provider.dart';
import '../../ui/circular_bar/circle_button_widget.dart';
import '../../utils/helper.dart';

class ControlPanelWidget extends StatefulWidget {
  @override
  _ControlPanelWidgetState createState() => _ControlPanelWidgetState();
}

class _ControlPanelWidgetState extends State<ControlPanelWidget>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation opacityAnimation;
  AppProvider appProvider;
  TasbihDailyListProvider tasbihDailyListProvider;
  Size adAvaliableSize = Size.zero;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: 800,
        ));
    opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));
    Future.delayed(const Duration(milliseconds: 0), () {
      tasbihDailyListProvider =
          Provider.of<TasbihDailyListProvider>(context, listen: false);
    });
  }

  bool countProcessStarted1 = false;
  bool countProcessStarted8 = false;
  bool countProcessStarted10 = false;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    AdsService adsService = GetIt.I.get<AdsService>();
    appProvider.addListener(() async {
      if (appProvider.countProcessStarted) {
        countProcessStarted1 = await Helper.setValueAfterDelay(
            countProcessStarted1, appProvider.countProcessStarted, 0);
        setState(() {});
        countProcessStarted8 = await Helper.setValueAfterDelay(
            countProcessStarted8, appProvider.countProcessStarted, 800);
        setState(() {});
        countProcessStarted10 = await Helper.setValueAfterDelay(
            countProcessStarted10, appProvider.countProcessStarted, 800);
        setState(() {
          controller.forward();
        });
      } else {
        countProcessStarted10 = await Helper.setValueAfterDelay(
            countProcessStarted10, appProvider.countProcessStarted, 0);
        setState(() {
          controller.reverse();
        });
        countProcessStarted8 = await Helper.setValueAfterDelay(
            countProcessStarted8, appProvider.countProcessStarted, 0);
        setState(() {});
        countProcessStarted1 = await Helper.setValueAfterDelay(
            countProcessStarted1, appProvider.countProcessStarted, 800);
        setState(() {});
      }
    });
    return Stack(
      ///= alignment: Alignment.bottomCenter,
      children: <Widget>[
        AnimatedPositioned(
          duration: Duration(
            milliseconds: 800,
          ),
          curve: Curves.easeInOut,
          width: MediaQuery.of(context).size.width,
          top: MediaQuery.of(context).size.height *
              (countProcessStarted8 ? 0.04 : 0.25),
          //  left: MediaQuery.of(context).size.width / 2 - (172 / 2) - 8,
          child: Center(
            child: Container(
              width: CustomTheme.CircleWidgetHeight,
              child: Stack(
                children: <Widget>[
                  CircleButtonWidget(),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: AnimatedOpacity(
                      opacity: !countProcessStarted1 ? 1 : 0,
                      duration: Duration(milliseconds: 400),
                      child: ClipOval(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(40),
                          child: StartButtonWidget(
                              child: Center(
                                child: AutoSizeText('Start',
                                    style: CustomTheme.startTextStyle),
                              ),
                              width: 60,
                              height: 60,
                              color: Colors.green),

                          // Container(
                          //   decoration: BoxDecoration(
                          //     boxShadow: <BoxShadow>[BoxShadow(color: Colors.black)],
                          //     borderRadius: BorderRadius.circular(40),
                          //     color: CustomTheme.doneColor1,
                          //     border: Border.all(
                          //         width: 3,
                          //         color: CustomTheme.trackColor.withOpacity(0.4)),
                          //   ),
                          //   width: 60,
                          //   height: 60,
                          //   child: Center(
                          //     child: AutoSizeText('Start',
                          //         style: CustomTheme.startTextStyle),
                          //   ),
                          // ),
                          onTap: () {
                            Provider.of<AppProvider>(context, listen: false)
                                .startCountProcess();
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        //),

        Container(
          padding: EdgeInsets.only(bottom: 0, left: 20, right: 20),
          child: !countProcessStarted10
              ? null
              : FadeTransition(
                  opacity: opacityAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        alignment: Alignment.topLeft,
                        child: !countProcessStarted10
                            ? null
                            : FadeTransition(
                                opacity: opacityAnimation,
                                child: BackButton(
                                  color: CustomTheme.color1,
                                ),
                              ),
                      ),
                      Container(
                        height: CustomTheme.CircleWidgetHeight - 20,
                      ),
                      ControlButtonsWidget(),
                      Container(
                        margin: EdgeInsets.only(top: 15, bottom: 15),
                        child: SpeedSliderWidget(),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 15),
                        child: VibrationSliderWidget(),
                      ),
                      MeasuredSize(
                        onChange: (Size size) {
                          setState(() {
                            adAvaliableSize = size;
                            print("SSSSSSSSSSSSSSIE ${size.height}");
                          });
                        },
                        child: Expanded(
                          child: adAvaliableSize?.height >=
                                  adsService.banner2Size.height
                              ? AdmobBanner(
                                  adUnitId: adsService.getBanner2AdUnitId(),
                                  adSize: adsService.banner2Size)
                              : AdmobBanner(
                                  adUnitId: adsService.getBanner2AdUnitId(),
                                  adSize: adsService.bannerSize),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ],
    );
  }
}
