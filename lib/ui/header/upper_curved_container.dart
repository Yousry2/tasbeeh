import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import './settings_button_widget.dart';
import 'create_account_button_widget.dart';
import '../../custom_theme.dart';
import '../../providers/app_provider.dart';
import '../../providers/tasbih_daily_list_provider.dart';
import '../../utils/animated_opacity_widget.dart';
import '../../utils/header_clipper.dart';
import '../../utils/helper.dart';

class UpperCurvedContainer extends StatefulWidget {
  @override
  _UpperCurvedContainerState createState() => _UpperCurvedContainerState();
}

class _UpperCurvedContainerState extends State<UpperCurvedContainer> {
  var countProcessStarted1 = false;
  var countProcessStarted2 = false;
  var countProcessStarted3 = false;
  var countProcessStarted4 = false;
  var countProcessStarted5 = false;
  AppProvider appProvider;

  @override
  void dispose() {
    appProvider.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    appProvider = Provider.of<AppProvider>(context);
    int _milliseconds = 200;
    /* else {
        countProcessStarted.reversed
            .toList()
            .asMap()
            .forEach((index, element) async {
          await Helper.setValueAfterDelay(element, appProvider.countProcessStarted,
              index == 0 ? 0 : _milliseconds);
              setState(() {
                countProcessStarted = countProcessStarted;
              });
        });
      }*/
    appProvider.addListener(() async {
      if (appProvider.countProcessStarted) {
        countProcessStarted1 = await Helper.setValueAfterDelay(
            countProcessStarted1, appProvider.countProcessStarted, 0);
        setState(() {});
        countProcessStarted2 = await Helper.setValueAfterDelay(
            countProcessStarted2,
            appProvider.countProcessStarted,
            _milliseconds);
        setState(() {});
        countProcessStarted3 = await Helper.setValueAfterDelay(
            countProcessStarted3,
            appProvider.countProcessStarted,
            _milliseconds);
        setState(() {});
        countProcessStarted4 = await Helper.setValueAfterDelay(
            countProcessStarted4,
            appProvider.countProcessStarted,
            _milliseconds);
        setState(() {});
        countProcessStarted5 = await Helper.setValueAfterDelay(
            countProcessStarted5,
            appProvider.countProcessStarted,
            _milliseconds);
        setState(() {});
      } else {
        countProcessStarted5 = await Helper.setValueAfterDelay(
            countProcessStarted5, appProvider.countProcessStarted, 0);
        setState(() {});
        countProcessStarted4 = await Helper.setValueAfterDelay(
            countProcessStarted4,
            appProvider.countProcessStarted,
            _milliseconds);
        setState(() {});
        countProcessStarted3 = await Helper.setValueAfterDelay(
            countProcessStarted3,
            appProvider.countProcessStarted,
            _milliseconds);
        setState(() {});
        countProcessStarted2 = await Helper.setValueAfterDelay(
            countProcessStarted2,
            appProvider.countProcessStarted,
            _milliseconds);
        setState(() {});
        countProcessStarted1 = await Helper.setValueAfterDelay(
            countProcessStarted1,
            appProvider.countProcessStarted,
            _milliseconds);
        setState(() {});
      }
    });
    return AnimatedOpacityWidget(
      showCondition: !countProcessStarted5,
      direction: Directions.top,
      child: Container(
        child: ClipPath(
          clipper: HeaderClipper(),
          child: Container(
            height: MediaQuery.of(context).size.height * .35,
            child: LayoutBuilder(
              builder: (context, constraints) => Container(
                decoration: BoxDecoration(
                  gradient: CustomTheme.curveGradient,
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                          right: 15, left: 15, top: 15, bottom: 15),
                      height: constraints.maxHeight * .80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          AnimatedOpacityWidget(
                              direction: Directions.top,
                              showCondition: !countProcessStarted1,
                              child: _topRow()),
                          AnimatedOpacityWidget(
                            showCondition: !countProcessStarted2,
                            direction: Directions.top,
                            // margin: EdgeInsets.only(top: 20),
                            child: Text(
                              'Misbaha',
                              textAlign: TextAlign.center,
                              style: CustomTheme.titleStyle,
                            ),
                          ),
                          //Spacer(),
                          constraints.maxHeight <
                                  CustomTheme.CompactDeviceHeaderHeight
                              ? Container(
                                  height: 30,
                                )
                              : AnimatedOpacityWidget(
                                  direction: Directions.top,
                                  showCondition: !countProcessStarted3,
                                  child: _bottomRow()),
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
    );
  }

  Container _bottomRow() {
    return Container(
      child: Consumer<TasbihDailyListProvider>(
          builder: (context, tasbihDailyListProvider, ch) {
        var numberOfRemaningTasbihGroups =
            tasbihDailyListProvider.choosenTasbih?.numberOfDailyGroups < 1
                ? 0
                : tasbihDailyListProvider.choosenTasbih?.numberOfDailyGroups >=
                        tasbihDailyListProvider
                            .choosenTasbih?.numberOfGroupsDoneToday
                    ? tasbihDailyListProvider
                            .choosenTasbih?.numberOfDailyGroups -
                        tasbihDailyListProvider
                            .choosenTasbih?.numberOfGroupsDoneToday
                    : 0;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(7),
              decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(5),
                  // border: Border.all(color: CustomTheme.infoTxtColor),
                  ),
              child: Text(
                'Done: \n ${tasbihDailyListProvider.choosenTasbih?.numberOfGroupsDoneToday}',
                textAlign: TextAlign.center,
                style: CustomTheme.infoTxtStyle,
              ),
            ),
            Container(
              padding: EdgeInsets.all(7),
              decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(5),
                  // border: Border.all(color: CustomTheme.infoTxtColor),
                  ),
              child: Text(
                'Remaining: \n $numberOfRemaningTasbihGroups',
                textAlign: TextAlign.center,
                style: CustomTheme.infoTxtStyle,
              ),
            ),
          ],
        );
      }),
    );
  }

  Container _topRow() {
    return Container(
      //  margin: EdgeInsetsDirectional.only(top: 20, start: 10, end: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CreateAccountButtonWidget(),
          SettingsButtonWidget(),
        ],
      ),
    );
  }
}
