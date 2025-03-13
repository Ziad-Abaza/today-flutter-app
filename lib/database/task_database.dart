import 'package:myapp/database/database_helper.dart';
import 'package:myapp/database/task_model.dart';

class TaskDatabase {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  Future<int> insertTask(Task task) async {
    final db = await dbHelper.database;
    return await db.insert('tasks', task.toMap());
  }

  Future<List<Task>> getAllTasks() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> tasks = await db.query('tasks');
    return tasks.map((e) => Task.fromMap(e)).toList();
  }

  Future<int> updateTask(Task task) async {
    final db = await dbHelper.database;
    return await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> deleteTask(int id) async {
    final db = await dbHelper.database;
    return await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<Task?> getTaskById(int taskId) async {
    final db = await dbHelper.database;
    List<Map<String, dynamic>> result = await db.query(
      'tasks',
      where: 'id = ?',
      whereArgs: [taskId],
    );

    if (result.isNotEmpty) {
      return Task.fromMap(result.first);
    }
    return null;
  }
}
