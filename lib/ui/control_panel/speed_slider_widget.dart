import 'package:flutter/material.dart';
import 'package:misbaha_app/custom_theme.dart';
import 'package:misbaha_app/providers/tasbih_daily_list_provider.dart';
import 'package:misbaha_app/utils/slider_widget.dart';
import 'package:provider/provider.dart';

class SpeedSliderWidget extends StatefulWidget {
  @override
  _SpeedSliderWidgetState createState() => _SpeedSliderWidgetState();
}

class _SpeedSliderWidgetState extends State<SpeedSliderWidget> {
  // final List<Map<String, int>> sliderValueMap;
  // final int sliderValue;

  int sliderValue = 6;

  List<Map<String, int>> sliderValueMap = [
    {'value': 1, 'countingSpeed': 2000},
    {'value': 2, 'countingSpeed': 1800},
    {'value': 3, 'countingSpeed': 1600},
    {'value': 4, 'countingSpeed': 1400},
    {'value': 5, 'countingSpeed': 1200},
    {'value': 6, 'countingSpeed': 1000},
    {'value': 7, 'countingSpeed': 800},
    {'value': 8, 'countingSpeed': 600},
    {'value': 9, 'countingSpeed': 400},
    {'value': 10, 'countingSpeed': 200},
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<TasbihDailyListProvider>(
      builder: (context, tasbihDailyListProvider, ch) {
        final slidertmp = sliderValueMap.firstWhere((element) {
          return tasbihDailyListProvider.choosenTasbih.countingSpeed ==
              element['countingSpeed'];
        }, orElse: () {
          sliderValue = 6;
        });
        if (slidertmp != null) sliderValue = slidertmp['value'];

        return SliderWidget(
          max: 10,
          min: 1,
          title: 'Speed : ',
          sliderValue: sliderValue.toDouble(),
          sliderValueMap: sliderValueMap,
          valueChanged: (value) {
            setState(() {
              tasbihDailyListProvider.setCountingSpeed(
                  sliderValueMap.firstWhere((element) =>
                      element['value'] == value.toInt())['countingSpeed']);
            });
          },
        );
      },
    );
  }
}
