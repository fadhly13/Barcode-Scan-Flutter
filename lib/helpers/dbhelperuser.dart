import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:eas_test_flutter_barcode_scanner/models/user.dart';

class DbHelperUser {
  static DbHelperUser? _dbHelper;
  static Database? _database;

  DbHelperUser._createObject();

  factory DbHelperUser() {
    if (_dbHelper == null) {
      _dbHelper = DbHelperUser._createObject();
    }
    return _dbHelper!;
  }

  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'users.db';

    print(path);

    var todoDataBase = openDatabase(path, version: 1, onCreate: _createDb);

    return todoDataBase;
  }

  void _createDb(Database db, int version) async {
    await db.execute('''
    CREATE TABLE users (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      username TEXT,
      password TEXT
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
    var mapList = await db?.query('users', orderBy: 'id');
    return mapList;
  }

  //read
  Future<User?> getLogin(String username, String password) async {
    Database? db = await database;
    var mapList = await db?.rawQuery(
        "SELECT * FROM users WHERE username='$username' AND password='$password'");

    if (mapList!.length == 0) {
      return null;
    }

    if (mapList!.length > 0) {
      return User.fromMap(mapList.first);
    }

    return null;
  }

  //create
  Future<int?> insert(User object) async {
    Database? db = await database;
    int? count = await db?.insert('users', object.toMap());
    return count;
  }

  //update
  Future<int?> update(User object) async {
    Database? db = await database;
    int? count = await db?.update('users', object.toMap(),
        where: 'id=?', whereArgs: [object.id]);

    return count;
  }

  //delete
  Future<int?> delete(int id) async {
    Database? db = await database;
    int? count = await db?.delete('users', where: 'id=?', whereArgs: [id]);
    return count;
  }

  Future<List<User>> gethasilscanList() async {
    var hasilscanMapList = await select();
    int? count = hasilscanMapList?.length;
    List<User> hasilscanList = <User>[];
    for (int i = 0; i < count!; i++) {
      hasilscanList.add(User.fromMap(hasilscanMapList![i]));
    }
    return hasilscanList;
  }
}
