import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:misbaha_app/utils/admob_flutter_service_.dart';
import 'package:misbaha_app/utils/ads_service.dart';

class AppProvider with ChangeNotifier {
  var _countProcessStarted = false;

  get countProcessStarted {
    return _countProcessStarted;
  }

  startCountProcess() {
    _countProcessStarted = true;
    AdsService adsService = GetIt.I.get<AdsService>();
    // adsService.hideBanner1();
    // adsService.showBanner2();
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
