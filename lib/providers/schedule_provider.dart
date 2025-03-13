import 'package:flutter/material.dart';
import 'package:myapp/database/schedule_model.dart';
import 'package:myapp/database/schedule_database.dart';

class ScheduleProvider with ChangeNotifier {
  final ScheduleDatabase _scheduleDb = ScheduleDatabase();
  List<Schedule> _schedules = [];

  List<Schedule> get schedules => _schedules;

  Future<void> loadSchedules() async {
    _schedules = await _scheduleDb.getAllSchedules();
    notifyListeners();
  }

  Future<void> addSchedule(Schedule schedule) async {
    await _scheduleDb.insertSchedule(schedule);
    _schedules.add(schedule);
    notifyListeners();
  }

  Future<void> updateSchedule(Schedule schedule) async {
    await _scheduleDb.updateSchedule(schedule);
    int index = _schedules.indexWhere((s) => s.id == schedule.id);
    if (index != -1) {
      _schedules[index] = schedule;
    }
    notifyListeners();
  }

  Future<void> deleteSchedule(int id) async {
    await _scheduleDb.deleteSchedule(id);
    _schedules.removeWhere((s) => s.id == id);
    notifyListeners();
  }

  Future<void> toggleScheduleStatus(int id, bool newStatus) async {
    await _scheduleDb.toggleScheduleStatus(id, newStatus);
    int index = _schedules.indexWhere((s) => s.id == id);
    if (index != -1) {
      _schedules[index].isEnabled = newStatus;
    }
    notifyListeners();
  }

  Future<Schedule?> getSchedule(int id) async {
    return await _scheduleDb.getSchedule(id);
  }
}
