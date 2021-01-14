import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database _db;
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();
  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "farm.db");
    var ourDb = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute("CREATE TABLE user ("
            "id integer primary key AUTOINCREMENT,"
            "username TEXT,"
            "password TEXT"
            ")");
        await db.execute("CREATE TABLE farmer ("
            "id integer primary key AUTOINCREMENT,"
            "name TEXT,"
            "phone TEXT,"
            "country TEXT"
            ")");
      },
    );
    return ourDb;
  }
}
