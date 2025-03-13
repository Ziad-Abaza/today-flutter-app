import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/database/task_model.dart';
import 'package:myapp/providers/task_provider.dart';

class TaskItem extends StatelessWidget {
  final Task task;

  const TaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: task.isCompleted ? const Color(0x8F72C9CE) : const Color(0xFFf8f9fa),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              task.title,
              style: TextStyle(
                color: task.isCompleted ? const Color(0xFF155724) : const Color(0xFF063454),
                fontSize: 16,
                fontWeight: task.isCompleted ? FontWeight.w600 : FontWeight.w500,
                decoration: task.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
              ),
            ),
          ),
          Checkbox(
            value: task.isCompleted,
            onChanged: (value) {
              Provider.of<TaskProvider>(context, listen: false).toggleTaskStatus(task.id!);
            },
            activeColor: const Color(0xFF063454),
          ),
        ],
      ),
    );
  }
}
