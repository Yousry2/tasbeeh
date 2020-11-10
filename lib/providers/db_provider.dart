import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:misbaha_app/providers/tasbih_daily_list_provider.dart';
import 'package:misbaha_app/services/db_service.dart';

class DBProvider {
  DBProvider(TasbihDailyListProvider tasbihDailyListProvider) {
    DBService dbService = GetIt.instance.get<DBService>();
    dbService.startDataBase().then((value) => dbService
        .retrieveTasbih()
        .then((value) => tasbihDailyListProvider.updateTasbihList(value)));
    ;

  }
  Future<DBService> updateTasbihListInDataBase(
      TasbihDailyListProvider tasbihDailyListProvider) async {
    DBService dbService = GetIt.instance.get<DBService>();
    dbService
        .updateTasbihListInDataBase(tasbihDailyListProvider.userTasbihList);
  }
}
