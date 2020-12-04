import 'package:flutter/material.dart';
import 'package:misbaha_app/custom_theme.dart';
import 'package:misbaha_app/providers/tasbih_daily_list_provider.dart';
import 'package:provider/provider.dart';

class SliderWidget extends StatelessWidget {
  final double sliderValue;
  final List<Map<String, int>> sliderValueMap;
  final String title;
  final double min;
  final double max;
  final int divisions;
  final Function valueChanged;

  SliderWidget({
    this.sliderValue,
    this.sliderValueMap,
    this.title,
    this.min,
    this.max,
    this.divisions = 9,
    this.valueChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            20,
          ),
          border: Border.all(color: CustomTheme.bgColor1)),
      padding: EdgeInsets.only(
        left: 20,
        top: 1,
        bottom: 1,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(color: CustomTheme.color1),
          ),
          Expanded(
            child: Slider(
              value: sliderValue.toDouble(),
              onChanged: (value) {
                this.valueChanged(value);
              },
              min: min,
              max: max,
              divisions: divisions,
              label: "$sliderValue",
            ),
          ),
        ],
      ),
    );
  }
}
