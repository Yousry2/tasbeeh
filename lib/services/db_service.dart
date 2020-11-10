import 'package:flutter/cupertino.dart';
import 'package:misbaha_app/models/tasbih.dart';
import 'package:misbaha_app/providers/tasbih_daily_list_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBService with ChangeNotifier {
  Database database;
  TasbihDailyListProvider tasbihDailyListProvider;

  // Future<DBService> fromK(
  //     TasbihDailyListProvider tasbihDailyListProvider) async {
  //   this.tasbihDailyListProvider = tasbihDailyListProvider;
  //   await startDataBase();
  //   List<Tasbih> t = await retrieveTasbih();
  //   tasbihDailyListProvider.updateTasbihList(t);
  //   return this;
  // }

  // Future<DBService> fromT(
  //     TasbihDailyListProvider tasbihDailyListProvider) async {
  //   print('22222222222222222222222222');
  //   if (database != null) {
  //     updateTasbihList(tasbihDailyListProvider.userTasbihList);
  //   }
  //   return this;
  // }

  Future<void> startDataBase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'tasbih.db');
    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) {
      db.execute(
          'CREATE TABLE Tasbih (id INTEGER PRIMARY KEY, name TEXT, numberOfDailyGroups INTEGER, ' +
              'numberOfTasbihPerGroup INTEGER, numberOfGroupsDoneToday INTEGER,numberOfLastCountValue INTEGER, ' +
              'countingSpeed INTEGER, active INTEGER, tOrder INTEGER)');
    });
  }

  Future<void> updateTasbih(Tasbih tasbih) async {
    await database.insert(
      'Tasbih',
      tasbih.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateTasbihListInDataBase(List<Tasbih> tasbihList) async {
    if (database != null) {
      if (tasbihList == null) tasbihList = [];
      await database.delete(
        'Tasbih',
      );
      tasbihList.forEach((element) {
        updateTasbih(element);
      });
    }
  }

  Future<List<Tasbih>> retrieveTasbih() async {
    if (database != null) {
      print('sssssssssssssssssssssssssssssssssssssssssssss');
      final List<Map<String, dynamic>> maps =
          await database.query('Tasbih', orderBy: 'tOrder');

      // Convert the List<Map<String, dynamic> into a List<Dog>.
      return List.generate(maps.length, (i) {
        return Tasbih.toObject((maps[i]));
      });
    }
  }
}
