import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  var _countProcessStarted = false;

  get countProcessStarted {
    return _countProcessStarted;
  }

  startCountProcess() {
    _countProcessStarted = true;
    notifyListeners();
  }

  stopCountProcess() {
    _countProcessStarted = false;
    notifyListeners();
  }

  toggleCountProcess() {
    _countProcessStarted = !_countProcessStarted;
    notifyListeners();
  }
}
