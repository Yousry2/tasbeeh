import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:misbaha_app/services/vibration_service.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';

import '../../providers/tasbih_daily_list_provider.dart';

class TouchPanelWidget extends StatefulWidget {
  @override
  _TouchPanelWidgetState createState() => _TouchPanelWidgetState();
}

class _TouchPanelWidgetState extends State<TouchPanelWidget>
    with SingleTickerProviderStateMixin {
  Offset startPosition;
  Offset currentPosition;
  Duration lastTimeStamp;
  Timer countTimer;
  int countingSpeed;
  var oneCountDuration = 1000;

  TasbihDailyListProvider tasbihDailyListProvider;
  TasbihDailyListProvider tasbihDailyListProviderWithListener;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 0), () {
      tasbihDailyListProvider =
          Provider.of<TasbihDailyListProvider>(context, listen: false);

      tasbihDailyListProviderWithListener =
          Provider.of<TasbihDailyListProvider>(context, listen: false);
      tasbihDailyListProviderWithListener
          .addListener(tasbihDailyListProviderWithListenerChanged);
    });
  }

  @override
  dispose() {
    tasbihDailyListProviderWithListener
        .removeListener(tasbihDailyListProviderWithListenerChanged);

    super.dispose();
  }

  Future<void> checkVibration() async {
    print('i am there');
    if (await Vibration.hasVibrator()) {
      print('has vibrator');
      Vibration.vibrate();
      if (await Vibration.hasAmplitudeControl()) {
        print('has amplitude');
        Vibration.vibrate(amplitude: 128);
      }
      if (await Vibration.hasCustomVibrationsSupport()) {
        print('has vibrationsupport');
        Vibration.vibrate(intensities: [1, 255]);
      }
    }
  }

  tasbihDailyListProviderWithListenerChanged() {
    if (tasbihDailyListProviderWithListener.countingStarted) {
      if (countTimer == null ||
          !countTimer.isActive ||
          (countTimer.isActive &&
              tasbihDailyListProviderWithListener.choosenTasbih.countingSpeed !=
                  countingSpeed)) {
        _increaseCountByTimer();
      }
    } else {
      if (!(countTimer == null) && countTimer.isActive) {
        _stopCounting();
      }
    }
  }

  changeTimerSpeed() {
    tasbihDailyListProvider.setCountSpeed(10);
  }

  _increaseCountByTimer() {
    var currenTasbih = tasbihDailyListProvider.choosenTasbih;
    countingSpeed = currenTasbih.countingSpeed;
    countTimer?.cancel();
    countTimer = null;
    countTimer =
        Timer.periodic(new Duration(milliseconds: countingSpeed), (timer) {
      if (currenTasbih.numberOfLastCountValue >=
          currenTasbih.numberOfTasbihPerGroup) {
        Vibration.vibrate(duration: 200, repeat: 1);
        countTimer.cancel();
        tasbihDailyListProvider.stopCounting();
        tasbihDailyListProvider.increaseTasbihDoneToday();
      } else {
        _increaseCount();
      }
    });
  }

  _increaseCount() {
    tasbihDailyListProvider.increaseCurrentTasbihCount();
    VibrationService vibrationService = GetIt.instance.get<VibrationService>();
    vibrationService.vibrate();
  }

  _updateCountSpeed() {
    countTimer.cancel();
    countTimer = null;
    countTimer = new Timer.periodic(
        new Duration(milliseconds: oneCountDuration), (timer) {
      Vibration.vibrate(duration: 20, intensities: [1, 100], repeat: 1);
    });
  }

  _stopCounting() {
    countTimer?.cancel();
    countTimer = null;
  }

  startCalculateDrag(DragStartDetails dsd) {
    startPosition = dsd.globalPosition;
    lastTimeStamp = dsd.sourceTimeStamp;
    print('startPosition : $startPosition');
  }

  updateCalculateDrag(DragUpdateDetails dsd) {
    currentPosition = dsd.delta;

    if (currentPosition.dy.abs() > .1) {
      Duration timeMargin = dsd.sourceTimeStamp - lastTimeStamp;
      if (currentPosition.dy.abs() / timeMargin.inMilliseconds > 0.045) {
        // print(currentPosition.dy.abs() / timeMargin.inMilliseconds  );
        if (currentPosition.dy > 0)
          oneCountDuration = oneCountDuration - 100;
        else if (currentPosition.dy < 0)
          oneCountDuration = oneCountDuration + 100;
        print(timeMargin.inMilliseconds);
      }
    }
    lastTimeStamp = dsd.sourceTimeStamp;
    //print('currentPosition : $currentPosition');
  }

  @override
  Widget build(BuildContext context) {
    checkVibration().then((value) => null);
    return Container();

    //  GestureDetector(
    //   // onLongPressStart: (_) => _increaseCount(),
    //   // onLongPressEnd: (_) => _stopCounting(),
    //   // onVerticalDragStart: (dsd) {
    //   //   _increaseCount();
    //   //   startCalculateDrag(dsd);
    //   // },
    //   // onVerticalDragUpdate: (dsd) {
    //   //   updateCalculateDrag(dsd);
    //   //   _updateCountSpeed();
    //   // },
    //   // onVerticalDragDown: (dsd) => _stopCounting,
    //   child: Container(
    //     height: 300,
    //     width: 300,
    //     color: Colors.black26,
    //   ),
    // );
  }
}
