import 'package:flutter/material.dart';
import 'package:misbaha_app/custom_theme.dart';
import 'package:misbaha_app/providers/app_provider.dart';
import 'package:misbaha_app/providers/tasbih_daily_list_provider.dart';
import 'package:misbaha_app/ui/control_panel/control_button.dart';
import 'package:provider/provider.dart';

class ControlButtonsWidget extends StatefulWidget {
  const ControlButtonsWidget({
    Key key,
  }) : super(key: key);

  @override
  _ControlButtonsWidgetState createState() => _ControlButtonsWidgetState();
}

class _ControlButtonsWidgetState extends State<ControlButtonsWidget> {
  TasbihDailyListProvider tasbihDailyListProvider;

  Function resumeCount() {
    Provider.of<TasbihDailyListProvider>(context, listen: false)
        .startCounting();
  }

  Function resetCount() {
    Provider.of<TasbihDailyListProvider>(context, listen: false)
        .resetCurrentTasbih();
  }

  Function goNextTasbihInList() {
    pauseCount();
    Provider.of<TasbihDailyListProvider>(context, listen: false)
        .goToNextTasbih();
  }

  Function goPreviousTasbihInList() {
    pauseCount();
    Provider.of<TasbihDailyListProvider>(context, listen: false)
        .goToPreviousTasbih();
  }

  Function pauseCount() {
    Provider.of<TasbihDailyListProvider>(context, listen: false).stopCounting();
  }

  Function newCount() {
    Provider.of<TasbihDailyListProvider>(context, listen: false)
        .newTasbihGroup();
  }

  Function stop() {
    Provider.of<TasbihDailyListProvider>(context, listen: false).stopCounting();
    Provider.of<AppProvider>(context, listen: false).stopCountProcess();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TasbihDailyListProvider>(
        builder: (context, tasbihDailyListProvider, ch) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ControlButton(
            text: 'Previous',
            color: CustomTheme.color3,
            icon: Icons.navigate_before,
            onPress: goPreviousTasbihInList,
          ),
          /*
          ControlButton(
            text: 'stop',
            color: CustomTheme.color3,
            icon: Icons.stop,
            onPress: stop,
          ),*/
          Spacer(
            flex: 1,
          ),
          ControlButton(
            text: 'reset',
            color: CustomTheme.color3,
            icon: Icons.refresh,
            onPress: resetCount,
          ),
          Spacer(
            flex: 4,
          ),
          tasbihDailyListProvider.countingStarted
              ? ControlButton(
                  text: 'Pause',
                  color: CustomTheme.color3,
                  icon: Icons.pause,
                  onPress: pauseCount,
                )
              : tasbihDailyListProvider.choosenTasbih.numberOfLastCountValue >=
                      tasbihDailyListProvider
                          .choosenTasbih.numberOfTasbihPerGroup
                  ? ControlButton(
                      text: 'New',
                      color: CustomTheme.color3,
                      icon: Icons.play_circle_outline,
                      onPress: newCount,
                    )
                  : ControlButton(
                      text: 'Resume',
                      color: CustomTheme.color3,
                      icon: Icons.play_arrow,
                      onPress: resumeCount,
                    ),
          Spacer(
            flex: 1,
          ),
          ControlButton(
            text: 'Next',
            color: CustomTheme.color3,
            icon: Icons.navigate_next,
            onPress: goNextTasbihInList,
          ),
        ],
      );
    });
  }
}
