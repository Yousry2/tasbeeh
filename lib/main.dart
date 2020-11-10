import 'package:appodeal_flutter/appodeal_flutter.dart';
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
import 'package:provider/provider.dart';
import 'home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  setupAppoDeal();
  setup();
  runApp(MyApp());
}

setupAppoDeal() {
  Appodeal.setAppKeys(
    androidAppKey: 'e497c4e4d4d1834fde018c5c22e542df9a4d6f889d0432c4',
    iosAppKey: '<your-appodeal-ios-key>',
  );
  Appodeal.initialize(
      hasConsent: true,
      adTypes: [
        AdType.BANNER,
        AdType.INTERSTITIAL,
        AdType.REWARD,
      ],
      testMode: true);
}

void setup() {
  final getIt = GetIt.instance;
  getIt.registerSingleton<DBService>(DBService());
  getIt.registerSingleton<VibrationService>(VibrationService());
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
