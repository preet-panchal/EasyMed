import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DBUtils {
  static Future init() async {
    //set up the database
    var database = openDatabase(
      path.join(await getDatabasesPath(), 'reminder_manager.db'),
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE reminder_items(id INTEGER PRIMARY KEY,name TEXT, instructions TEXT, usage TEXT, date TEXT, time TEXT)');
      },
      version: 1,
    );

    print("Created DB $database.");
    return database;
  }
}
