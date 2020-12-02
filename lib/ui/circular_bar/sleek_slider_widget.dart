import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import './circle_button_internal_widget.dart';
import '../../custom_theme.dart';
import '../../models/tasbih.dart';

class SleekButtonWidget extends StatefulWidget {
  final Tasbih tasbih;
  final bool countingModeStarted;

  SleekButtonWidget({this.tasbih, this.countingModeStarted}) {
    print(this.countingModeStarted);
  }

  @override
  _SleekButtonWidgetState createState() => _SleekButtonWidgetState();
}

class _SleekButtonWidgetState extends State<SleekButtonWidget> {
  int _currentValue = 0;

  @override
  initState() {
    super.initState();
  }

  _customWidth01(bool countingModeStarted) {
    return countingModeStarted
        ? CustomSliderWidths(
            trackWidth: 2, progressBarWidth: 10, shadowWidth: 20)
        : CustomSliderWidths(
            trackWidth: 2, progressBarWidth: 10, shadowWidth: 20);
  }

  static final customColors01 = CustomSliderColors(
      dotColor: Colors.white.withOpacity(0.8),
      trackColor: CustomTheme.trackColor,
      progressBarColors: [
        CustomTheme.doneColor.withOpacity(0.9),
        CustomTheme.inProgressColor.withOpacity(0.9),
        CustomTheme.startColor.withOpacity(0.5),
      ],
      //shadowColor: Color(0XFFD7E2),
      shadowMaxOpacity: 0.05);

  InfoProperties getInforProperties(Tasbih tasbih) {
    return InfoProperties(
        mainLabelStyle: CustomTheme.mainLabelStyle,
        topLabelText: tasbih.name,
        topLabelStyle: CustomTheme.topLabelStyle,
        bottomLabelText: tasbih?.numberOfLastCountValue?.toStringAsFixed(0),
        bottomLabelStyle: CustomTheme.bottomLabelStyle);
  }

  CircularSliderAppearance _getCircularSliderAppearance(
      BuildContext context, Tasbih tasbih, bool countingModeStarted) {
    return CircularSliderAppearance(
      customWidths: _customWidth01(countingModeStarted),
      customColors: customColors01,
      infoProperties: getInforProperties(tasbih),
      startAngle: 120,
      angleRange: 300,
      size: CustomTheme.CircleWidgetHeight,
    );
    //  MediaQuery.of(context).size.height * .25);
  }

  // final CircularSliderAppearance appearance01 = CircularSliderAppearance(
  //     customWidths: customWidth01,
  //     customColors: customColors01,
  //     infoProperties: info,
  //     startAngle: 120,
  //     angleRange: 300,
  //     size: 500);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SleekCircularSlider(
              innerWidget: (_) => CircleButtonInternalWidget(
                topTxt: widget.tasbih.name,
                bottomTxt: '${widget.tasbih.numberOfLastCountValue}',
                countingModeStarted: widget.countingModeStarted,
              ),
              appearance: _getCircularSliderAppearance(
                  context, widget.tasbih, widget.countingModeStarted),
              initialValue: 100 *
                  (widget.tasbih.numberOfLastCountValue /
                      (widget.tasbih.numberOfTasbihPerGroup > 0
                          ? widget.tasbih.numberOfTasbihPerGroup
                          : 1)),
            )
          ],
        ),
      ),
    );
  }
}
