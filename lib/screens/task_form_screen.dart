import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/widget/input_field.dart';
import 'package:myapp/database/task_model.dart';
import 'package:myapp/providers/task_provider.dart';

class TaskFormScreen extends StatefulWidget {
  final int? taskId;
  const TaskFormScreen({super.key, this.taskId});

  @override
  _TaskFormScreenState createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  bool isCompleted = false;

  @override
  void initState() {
    super.initState();
    if (widget.taskId != null) {
      _loadTask(widget.taskId!);
    }
  }

  void _loadTask(int taskId) async {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    Task? task = await taskProvider.getTask(taskId);
    if (task != null) {
      setState(() {
        titleController.text = task.title;
        descriptionController.text = task.description ?? "";
        dateController.text = task.date ?? "";
        timeController.text = task.time ?? "";
        isCompleted = task.isCompleted;
      });
    }
  }

  void _saveTask() async {
    String title = titleController.text.trim();
    String description = descriptionController.text.trim();
    String date = dateController.text.trim();
    String time = timeController.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Title cannot be empty")),
      );
      return;
    }

    Task task = Task(
      id: widget.taskId,
      title: title,
      description: description,
      date: date,
      time: time,
      isCompleted: isCompleted,
    );

    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    if (widget.taskId == null) {
      await taskProvider.addTask(task);
    } else {
      await taskProvider.updateTask(task);
    }

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    bool isEditing = widget.taskId != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? "Edit Task" : "New Task",
          style: const TextStyle(
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InputField(
              label: "Task Title",
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
            ElevatedButton(
              onPressed: _saveTask,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF063454),
                foregroundColor: const Color(0xFFbfdee9),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
              ),
              child: Text(isEditing ? "Save Changes" : "Add Task"),
            ),
          ],
        ),
      ),
    );
  }
}
