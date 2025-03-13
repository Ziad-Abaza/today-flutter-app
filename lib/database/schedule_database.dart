import 'package:myapp/database/database_helper.dart';
import 'package:myapp/database/schedule_model.dart';

class ScheduleDatabase {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  Future<int> insertSchedule(Schedule schedule) async {
    final db = await dbHelper.database;
    return await db.insert('schedules', schedule.toMap());
  }

  Future<List<Schedule>> getAllSchedules() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> schedules = await db.query('schedules');
    return schedules.map((e) => Schedule.fromMap(e)).toList();
  }

  Future<Schedule?> getSchedule(int id) async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> result = await db.query(
      'schedules',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return Schedule.fromMap(result.first);
    }
    return null;
  }

  Future<int> updateSchedule(Schedule schedule) async {
    final db = await dbHelper.database;
    return await db.update(
      'schedules',
      schedule.toMap(),
      where: 'id = ?',
      whereArgs: [schedule.id],
    );
  }

  Future<int> deleteSchedule(int id) async {
    final db = await dbHelper.database;
    return await db.delete(
      'schedules',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

Future<int> toggleScheduleStatus(int id, bool newStatus) async {
  final db = await dbHelper.database;
  return await db.update(
    'schedules',
    {'isEnabled': newStatus ? 1 : 0},
    where: 'id = ?',
    whereArgs: [id],
  );
}

}
