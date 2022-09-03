import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/task.dart';

class DBHelper {
  static Database? _db;
  static const int _version = 1;
  static const String _tableName = "task";
  static const String _dbName = "tasks.db";

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }

    try {
      String path = join(await getDatabasesPath(), _dbName);
      print("DB path: $path");
      _db = await openDatabase(
        path,
        version: _version,
        onCreate: (db, version) {
          print('creating a new one');
          return db.execute(
            """
            CREATE TABLE $_tableName(
              id INTEGER PRIMARY KEY AUTOINCREMENT, 
              title STRING, 
              note TEXT,
              date STRING, 
              startTime STRING , 
              endTime STRING, 
              remind INTEGER, 
              repeat STRING, 
              color INTEGER, 
              isCompleted INTEGER
            )
            """,
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insert(Task? task) async {
    print('insert function called');
    return await _db?.insert(_tableName, task!.toJson()) ?? -1;
  }
}
