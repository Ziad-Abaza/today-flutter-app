import 'package:flutter/material.dart';
import 'package:myapp/database/schedule_model.dart';
import 'package:myapp/providers/schedule_provider.dart';
import 'package:myapp/widget/input_field.dart';
import 'package:provider/provider.dart';

class ScheduleFormScreen extends StatefulWidget {
  final String? scheduleId;
  const ScheduleFormScreen({super.key, this.scheduleId});

  @override
  _ScheduleFormScreenState createState() => _ScheduleFormScreenState();
}

class _ScheduleFormScreenState extends State<ScheduleFormScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  bool isEnabled = true;

  @override
  void initState() {
    super.initState();
    if (widget.scheduleId != null) {
      _loadSchedule();
    }
  }

  Future<void> _loadSchedule() async {
    final provider = Provider.of<ScheduleProvider>(context, listen: false);
    final schedule = await provider.getSchedule(int.parse(widget.scheduleId!));

    if (schedule != null) {
      setState(() {
        titleController.text = schedule.title;
        descriptionController.text = schedule.description ?? "";
        dateController.text = schedule.date;
        timeController.text = schedule.time;
        isEnabled = schedule.isEnabled;
      });
    }
  }

  void _saveSchedule() {
    final provider = Provider.of<ScheduleProvider>(context, listen: false);
    final isEditing = widget.scheduleId != null;

    final schedule = Schedule(
      id: isEditing ? int.parse(widget.scheduleId!) : null,
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      date: dateController.text.trim(),
      time: timeController.text.trim(),
      isEnabled: isEnabled,
    );

    if (isEditing) {
      provider.updateSchedule(schedule);
    } else {
      provider.addSchedule(schedule);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    bool isEditing = widget.scheduleId != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? "Edit Schedule" : "New Schedule",
          style: TextStyle(
            color: Color(0xFFbfdee9),
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: const Color(0xFF063454),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputField(
              label: "Title",
              icon: Icons.title,
              controller: titleController,
            ),
            const SizedBox(height: 15),
            InputField(
              label: "Description",
              icon: Icons.description,
              controller: descriptionController,
            ),
            const SizedBox(height: 15),
            InputField(
              label: "Date",
              icon: Icons.calendar_today,
              controller: dateController,
              keyboardType: TextInputType.datetime,
              isDateField: true,
            ),
            const SizedBox(height: 15),
            InputField(
              label: "Time",
              icon: Icons.access_time,
              controller: timeController,
              keyboardType: TextInputType.datetime,
              isTimeField: true,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Enable Schedule",
                  style: TextStyle(
                    color: const Color(0xFF063454),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Switch(
                  value: isEnabled,
                  onChanged: (value) {
                    setState(() {
                      isEnabled = value;
                    });
                  },
                  activeColor: const Color(0xFF063454),
                  activeTrackColor: const Color(0xFFbfdee9),
                  inactiveThumbColor: Colors.grey,
                  inactiveTrackColor: Colors.grey[300],
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveSchedule,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF063454),
                foregroundColor: Color(0xFFbfdee9),
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 30,
                ),
              ),
              child: Text(isEditing ? "Save Changes" : "Add Schedule"),
            ),
          ],
        ),
      ),
    );
  }
}
