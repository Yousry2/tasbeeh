import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';

const String VIBRATION_INTENSITY = "VibrationIntensity";

class VibrationService {
  int vibrateIntensity = 200;

  VibrationService() {
    getVibrationIntensity().then((value) => vibrateIntensity = value);
  }

  vibrate() {
    Vibration.vibrate(duration: vibrateIntensity);
    //Vibration.vibrate(duration: vibrateIntensity, intensities: [0, 100]);
  }

  _saveVibrationIntensity(int intensity) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(VIBRATION_INTENSITY, intensity);
  }

  Future<int> getVibrationIntensity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int intensity = (prefs.getInt(VIBRATION_INTENSITY) ?? 20);
    return intensity;
  }

  updateViberationIntensity(int intensity) {
    vibrateIntensity = intensity;
    _saveVibrationIntensity(intensity);
  }
}
