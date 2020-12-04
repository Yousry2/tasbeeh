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
  static const String banner3AndroidAppID =
      'ca-app-pub-6868525813510049/2844201328';
  static const String banner3AppleAppID =
      'ca-app-pub-6868525813510049/6828706038';
  static const String banner4AndroidAppID =
      'ca-app-pub-6868525813510049/6396433529';
  static const String banner4AppleAppID =
      'ca-app-pub-6868525813510049/4700208474';
  static const String banner5AndroidAppID =
      'ca-app-pub-6868525813510049/4964960024';
  static const String banner5AppleAppID =
      'ca-app-pub-6868525813510049/5977647034';

  AdmobBannerSize bannerSize = AdmobBannerSize.BANNER;
  AdmobBannerSize banner2Size = AdmobBannerSize.MEDIUM_RECTANGLE;
  AdmobBannerSize banner3Size = AdmobBannerSize.BANNER;
  AdmobBannerSize banner4Size = AdmobBannerSize.MEDIUM_RECTANGLE;
  AdmobBannerSize banner5Size = AdmobBannerSize.BANNER;
  initializeAds() {
    WidgetsFlutterBinding.ensureInitialized();
    // Initialize without device test ids.
    Admob.initialize();

    Admob.initialize(testDeviceIds: [
      '9DB7681BC24B9D460CFE6F7E08A5B76C',
      'A89A2059D8EBCE74A6D2E02A208890D4',
      '43240C235BA5735BB18466DD67E01461'
    ]);
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
        print("ADTYPE 111111111" + adType);
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

  String getBanner3AdUnitId() {
    if (Platform.isIOS) {
      return banner3AppleAppID;
    } else if (Platform.isAndroid) {
      return banner3AndroidAppID;
    }
    return null;
  }

  String getBanner4AdUnitId() {
    if (Platform.isIOS) {
      return banner4AppleAppID;
    } else if (Platform.isAndroid) {
      return banner4AndroidAppID;
    }
    return null;
  }

  String getBanner5AdUnitId() {
    if (Platform.isIOS) {
      return banner5AppleAppID;
    } else if (Platform.isAndroid) {
      return banner5AndroidAppID;
    }
    return null;
  }
}
