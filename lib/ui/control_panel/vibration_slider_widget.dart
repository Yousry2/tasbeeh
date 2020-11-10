import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:misbaha_app/custom_theme.dart';
import 'package:misbaha_app/providers/app_provider.dart';
import 'package:misbaha_app/providers/tasbih_daily_list_provider.dart';
import 'package:misbaha_app/providers/tick_provider.dart';
import 'package:misbaha_app/services/vibration_service.dart';
import 'package:misbaha_app/utils/slider_widget.dart';
import 'package:provider/provider.dart';

class VibrationSliderWidget extends StatefulWidget {
  @override
  _VibrationSliderWidgetState createState() => _VibrationSliderWidgetState();
}

class _VibrationSliderWidgetState extends State<VibrationSliderWidget>
    with SingleTickerProviderStateMixin {
  VibrationService vs = GetIt.instance.get<VibrationService>();

  @override
  void initState() {
    super.initState();
    sliderValue = vs.vibrateIntensity;
  }

  int sliderValue = 2;

  List<Map<String, int>> sliderValueMap = [
    {'value': 1, 'countingSpeed': 10},
    {'value': 2, 'countingSpeed': 20},
    {'value': 3, 'countingSpeed': 30},
    {'value': 4, 'countingSpeed': 40},
    {'value': 5, 'countingSpeed': 60},
    {'value': 6, 'countingSpeed': 80},
    {'value': 7, 'countingSpeed': 100},
    {'value': 8, 'countingSpeed': 110},
    {'value': 9, 'countingSpeed': 120},
    {'value': 10, 'countingSpeed': 130},
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<TickProvider>(
      builder: (context, tickProvider, ch) {
        final slidertmp = sliderValueMap.firstWhere((element) {
          return tickProvider.vibrationIntensity == element['countingSpeed'];
        }, orElse: () {
          sliderValue = 2;
        });
        if (slidertmp != null) sliderValue = slidertmp['value'];

        return SliderWidget(
          max: 10,
          min: 1,
          title: 'Viberation Intensity : ',
          sliderValue: sliderValue.toDouble(),
          sliderValueMap: sliderValueMap,
          valueChanged: (value) {
            setState(() {
              tickProvider.updateVibrationInensity(sliderValueMap.firstWhere(
                  (element) =>
                      element['value'] == value.toInt())['countingSpeed']);
            });
          },
        );
      },
    );
  }
}
