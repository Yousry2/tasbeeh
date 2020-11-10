import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:misbaha_app/services/vibration_service.dart';

class TickProvider with ChangeNotifier {
  var _vibrationIntensity = GetIt.I.get<VibrationService>().vibrateIntensity;

  get vibrationIntensity {
    return _vibrationIntensity;
  }

  updateVibrationInensity(int vibrationIntensity) {
    _vibrationIntensity = vibrationIntensity;
    GetIt.I
        .get<VibrationService>()
        .updateViberationIntensity(vibrationIntensity);
    notifyListeners();
  }
}
