// import 'dart:io';

// import 'package:firebase_admob/firebase_admob.dart';

// class AdsService {
//   static const String androidAppID = 'ca-app-pub-6868525813510049~6524286413';
//   static const String appleAppID = 'ca-app-pub-6868525813510049~3898123074';
//   static const String banner1AndroidAppID =
//       'ca-app-pub-6868525813510049/3133504618';
//   static const String banner1AppleAppID =
//       'ca-app-pub-6868525813510049/1628851259';
//   static const String banner2AndroidAppID =
//       'ca-app-pub-6868525813510049/3119888713';
//   static const String banner2AppleAppID =
//       'ca-app-pub-6868525813510049/6986788011';

//   static MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
//     keywords: <String>['flutterio', 'beautiful apps'],
//     contentUrl: 'https://flutter.io',
//     childDirected: false,
//   );

//   static BannerAd bannerAd1;
//   static BannerAd bannerAd2;
//   static InterstitialAd interstitialAd;

//   initializeAds() {
//     if (Platform.isIOS) {
//       FirebaseAdMob.instance.initialize(appId: appleAppID);
//     } else if (Platform.isAndroid) {
//       FirebaseAdMob.instance.initialize(appId: androidAppID);
//     }

//     bannerAd1 = BannerAd(
//       adUnitId: Platform.isIOS ? banner1AppleAppID : banner1AndroidAppID,
//       size: AdSize.smartBanner,
//       targetingInfo: targetingInfo,
//       listener: (MobileAdEvent event) {
//         print("BannerAd event is $event");
//       },
//     );

//     bannerAd2 = BannerAd(
//       adUnitId: Platform.isIOS ? banner2AppleAppID : banner2AndroidAppID,
//       size: AdSize.largeBanner,
//       targetingInfo: targetingInfo,
//       listener: (MobileAdEvent event) {
//         print("BannerAd event is $event");
//       },
//     );

//     interstitialAd = InterstitialAd(
//       adUnitId: InterstitialAd.testAdUnitId,
//       targetingInfo: targetingInfo,
//       listener: (MobileAdEvent event) {
//         print("InterstitialAd event is $event");
//       },
//     );
//   }

//   showBanner1() {
//     bannerAd1
//       // typically this happens well before the ad is shown
//       ..load()
//       ..show(
//         // Positions the banner ad 60 pixels from the bottom of the screen
//         anchorOffset: 0.0,
//         // Positions the banner ad 10 pixels from the center of the screen to the right
//         horizontalCenterOffset: 00.0,
//         // Banner Position
//         anchorType: AnchorType.bottom,
//       );
//   }

//   hideBanner1() {
//     bannerAd1?.dispose();
//   }

//   showBanner2() {
//     bannerAd2
//       // typically this happens well before the ad is shown
//       ..load()
//       ..show(
//         // Positions the banner ad 60 pixels from the bottom of the screen
//         anchorOffset: 0.0,
//         // Positions the banner ad 10 pixels from the center of the screen to the right
//         horizontalCenterOffset: 00.0,
//         // Banner Position
//         anchorType: AnchorType.bottom,
//       );
//   }

//   hideBanner2() {}

//   setupAppoDeal() {
//     // Appodeal.setAppKeys(
//     //   androidAppKey: 'e497c4e4d4d1834fde018c5c22e542df9a4d6f889d0432c4',
//     // );
//     // Appodeal.initialize(
//     //     hasConsent: true,
//     //     adTypes: [
//     //       AdType.BANNER,
//     //       AdType.INTERSTITIAL,
//     //       AdType.REWARD,
//     //     ],
//     //     testMode: true);
//   }
// }
