import 'package:flutter/foundation.dart';

enum CountModes {
  auto,
  onClick,
  onLongPress,
}

class CountModeProvider with ChangeNotifier {
  CountModes _countMode = CountModes.auto;

  get countMode {
    return _countMode;
  }

  changeCountMode(CountModes countMode) {
    _countMode = countMode;
    notifyListeners();
  }
}
