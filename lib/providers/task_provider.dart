import 'package:flutter/material.dart';
import 'package:myapp/database/task_database.dart';
import 'package:myapp/database/task_model.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  Future<void> loadTasks() async {
    _tasks = await TaskDatabase().getAllTasks();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await TaskDatabase().insertTask(task);
    await loadTasks();
  }

  Future<void> deleteTask(int id) async {
    await TaskDatabase().deleteTask(id);
    await loadTasks();
  }

  Future<void> updateTask(Task task) async {
    await TaskDatabase().updateTask(task);
    await loadTasks();
  }

  Future<Task?> getTask(int id) async {
    return await TaskDatabase().getTaskById(id);
  }

  Future<void> toggleTaskStatus(int taskId) async {
    Task? task = await TaskDatabase().getTaskById(taskId);
    if (task != null) {
      task.isCompleted = !task.isCompleted;
      await TaskDatabase().updateTask(task);
      await loadTasks();
    }
  }
}
