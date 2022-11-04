import 'dart:async';
import 'package:reminder/model/reminder.dart';
import 'package:sqflite/sqflite.dart';
import 'local_db_utils.dart';

class ReminderModel {
  Future<int> insertReminder(Reminder reminder) async {
    final db = await DBUtils.init();
    return db.insert(
      'reminder_items',
      reminder.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Reminder>> getAllReminders() async {
    final db = await DBUtils.init();
    final List maps = await db.query('reminder_items');
    List<Reminder> result = [];
    for (int i = 0; i < maps.length; i++) {
      result.add(Reminder.fromMap(maps[i]));
    }
    return result;
  }
}
