//import 'package:appodeal_flutter/appodeal_flutter.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:misbaha_app/providers/app_provider.dart';
import 'package:misbaha_app/providers/db_provider.dart';
import 'package:misbaha_app/providers/tasbih_daily_list_provider.dart';
import 'package:misbaha_app/providers/tick_provider.dart';
import 'package:misbaha_app/services/db_service.dart';
import 'package:misbaha_app/services/vibration_service.dart';
import 'package:misbaha_app/settings.dart';
import 'package:misbaha_app/utils/admob_flutter_service_.dart';
import 'package:misbaha_app/utils/ads_service.dart';
import 'package:provider/provider.dart';
import 'home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  setup();
  setupAds();
  runApp(MyApp());
}

setupAds() {
  AdsService adsService = GetIt.I.get<AdsService>();
  adsService.initializeAds();
  // adsService.showBanner1();
}

void setup() {
  final getIt = GetIt.instance;
  getIt.registerSingleton<DBService>(DBService());
  getIt.registerSingleton<VibrationService>(VibrationService());
  getIt.registerSingleton<AdsService>(AdsService());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => AppProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => TickProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => TasbihDailyListProvider(),
          ),
          ProxyProvider<TasbihDailyListProvider, DBProvider>(
            create: (BuildContext context) {
              return DBProvider(
                  Provider.of<TasbihDailyListProvider>(context, listen: false));
            },
            update: (BuildContext context,
                TasbihDailyListProvider tasbihDailyListProvider,
                DBProvider dbProvider) {
              dbProvider.updateTasbihListInDataBase(tasbihDailyListProvider);
              return dbProvider;
            },
          ),
        ],
        child: MaterialApp(
          title: 'Easy Tasbeeh',
          debugShowCheckedModeBanner: false,
          home: Home(),
          routes: {
            SettingsScreen.routeName: (ctx) => SettingsScreen(),
            Home.routeName: (ctx) => Home(),
          },
          theme: ThemeData(fontFamily: 'Cairo'),
        ));
  }
}
