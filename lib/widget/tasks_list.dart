import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:myapp/screens/task_form_screen.dart';
import 'package:provider/provider.dart';
import 'package:myapp/providers/task_provider.dart';
import 'package:myapp/widget/task_item.dart';
import 'package:myapp/screens/task_details_screen.dart';

class TasksList extends StatelessWidget {
  const TasksList({super.key});

  void _deleteTask(BuildContext context, int id) {
    Provider.of<TaskProvider>(context, listen: false).deleteTask(id);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        final tasks = taskProvider.tasks;

        return tasks.isEmpty
            ? const Center(
              child: Text(
                "No Tasks Available",
                style: TextStyle(
                  color: Color(0xFF063454),
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
            : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];

                return Slidable(
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => TaskFormScreen(taskId: task.id),
                            ),
                          ).then((_) => taskProvider.loadTasks());
                        },
                        backgroundColor: const Color(0xFFbfdee9),
                        icon: Icons.edit,
                        borderRadius: BorderRadius.circular(8),
                      ),

                      SlidableAction(
                        onPressed: (context) {
                          if (task.id != null) {
                            _deleteTask(context, task.id!);
                          } else {
                            print("Error: Task ID is null");
                          }
                        },
                        backgroundColor: const Color(0xFFbfdee9),
                        icon: Icons.delete,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskDetailsScreen(task: task),
                        ),
                      ).then((_) => taskProvider.loadTasks());
                    },
                    child: TaskItem(task: task),
                  ),
                );
              },
            );
      },
    );
  }
}
