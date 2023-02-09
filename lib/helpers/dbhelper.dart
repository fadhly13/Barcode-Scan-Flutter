import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:eas_test_flutter_barcode_scanner/models/hasilScan.dart';

class DbHelper {
  static DbHelper? _dbHelper;
  static Database? _database;

  DbHelper._createObject();

  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createObject();
    }
    return _dbHelper!;
  }

  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'hasilscans.db';

    print(path);

    var todoDataBase = openDatabase(path, version: 1, onCreate: _createDb);

    return todoDataBase;
  }

  void _createDb(Database db, int version) async {
    await db.execute('''
    CREATE TABLE hasilscans (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      iduser INTEGER,
      idscan TEXT,
      created DATETIME
    )
    ''');
  }

  Future<Database?> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database;
  }

  //read
  Future<List<Map<String, dynamic>>?> select() async {
    Database? db = await database;
    var mapList = await db?.query('hasilscans', orderBy: 'id');
    return mapList;
  }

  //create
  Future<int?> insert(HasilScan object) async {
    Database? db = await database;
    int? count = await db?.insert('hasilscans', object.toMap());
    return count;
  }

  //update
  Future<int?> update(HasilScan object) async {
    Database? db = await database;
    int? count = await db?.update('hasilscans', object.toMap(),
        where: 'id=?', whereArgs: [object.id]);

    return count;
  }

  //delete
  Future<int?> delete(int id) async {
    Database? db = await database;
    int? count = await db?.delete('hasilscans', where: 'id=?', whereArgs: [id]);
    return count;
  }

  Future<List<HasilScan>> gethasilscanList() async {
    var hasilscanMapList = await select();
    int? count = hasilscanMapList?.length;
    List<HasilScan> hasilscanList = <HasilScan>[];
    for (int i = 0; i < count!; i++) {
      hasilscanList.add(HasilScan.fromMap(hasilscanMapList![i]));
    }
    return hasilscanList;
  }
}
