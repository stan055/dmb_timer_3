import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'timer.dart';

class DBHelper {
  static Database _db;
  static const String ID = 'id';
  static const String NAME = 'name';
  static const String START = 'start';
  static const String END = 'end';
  static const String TABLE = 'Timer';
  static const String DB_NAME = 'timer1.db';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY, $NAME TEXT, $START INREGER, $END INTEGER)");
  }

  Future<Timer> save(Timer timer) async {
    var dbClient = await db;
    timer.id = await dbClient.insert(TABLE, timer.toMap());
    return timer;
    /*
    await dbClient.transaction((txn) async {
      var query = "INSERT INTO $TABLE ($NAME) VALUES ('" + employee.name + "')";
      return await txn.rawInsert(query);
    });
    */
  }

  Future<List<Timer>> getTimers() async {
    var dbClient = await db;
    List<Map> maps =
        await dbClient.query(TABLE, columns: [ID, NAME, START, END]);
    //List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List<Timer> timers = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        timers.add(Timer.fromMap(maps[i]));
      }
    }
    return timers;
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
  }

  Future<int> update(Timer timer) async {
    var dbClient = await db;
    return await dbClient
        .update(TABLE, timer.toMap(), where: '$ID = ?', whereArgs: [timer.id]);
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
