import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/cupertino.dart';

class AdsService {
  static const String androidAppID = 'ca-app-pub-6868525813510049~6524286413';
  static const String appleAppID = 'ca-app-pub-6868525813510049~3898123074';
  static const String banner1AndroidAppID =
      'ca-app-pub-6868525813510049/3133504618';
  static const String banner1AppleAppID =
      'ca-app-pub-6868525813510049/1628851259';
  static const String banner2AndroidAppID =
      'ca-app-pub-6868525813510049/3119888713';
  static const String banner2AppleAppID =
      'ca-app-pub-6868525813510049/6986788011';

  AdmobBannerSize bannerSize = AdmobBannerSize.BANNER;
  AdmobBannerSize banner2Size = AdmobBannerSize.MEDIUM_RECTANGLE;
  initializeAds() {
    WidgetsFlutterBinding.ensureInitialized();
    // Initialize without device test ids.
    Admob.initialize();

    Admob.initialize(testDeviceIds: ['9DB7681BC24B9D460CFE6F7E08A5B76C']);
    // Or add a list of test ids.
    if (Platform.isIOS) {
      Admob.requestTrackingAuthorization().then((value) => null);
    }
  }

  void handleEvent(
      AdmobAdEvent event, Map<String, dynamic> args, String adType) {
    switch (event) {
      case AdmobAdEvent.loaded:
        break;
      case AdmobAdEvent.opened:
        break;
      case AdmobAdEvent.closed:
        break;
      case AdmobAdEvent.failedToLoad:
        break;
      case AdmobAdEvent.rewarded:
        break;
      default:
    }
  }

  String getBannerAdUnitId() {
    if (Platform.isIOS) {
      return banner1AppleAppID;
    } else if (Platform.isAndroid) {
      return banner1AndroidAppID;
    }
    return null;
  }

  String getBanner2AdUnitId() {
    if (Platform.isIOS) {
      return banner2AppleAppID;
    } else if (Platform.isAndroid) {
      return banner2AndroidAppID;
    }
    return null;
  }
}
