import 'package:flutter/material.dart';
import 'package:myapp/database/task_model.dart';

class TaskDetailsScreen extends StatelessWidget {
  final Task task;

  const TaskDetailsScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          task.title,
          style: TextStyle(
            color: Color(0xFFbfdee9),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: const Color(0xFF063454),
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ====================== Description ======================
            _buildDetailSection(
              icon: Icons.description,
              title: "Description",
              content: task.description ?? "No description provided",
              isScrollable: true,
            ),
            const SizedBox(height: 15),

            // ====================== Date ======================
            _buildDetailSection(
              icon: Icons.calendar_today,
              title: "Date",
              content: task.date ?? "No date specified",
            ),
            const SizedBox(height: 15),

            // ====================== Time ======================
            _buildDetailSection(
              icon: Icons.access_time,
              title: "Time",
              content: task.time ?? "No time specified",
            ),
            const SizedBox(height: 15),

            // ====================== Completed Status ======================
            _buildDetailSection(
              icon: Icons.check_circle_outline,
              title: "Completed",
              content: task.isCompleted ? "Yes" : "No",
              contentColor: task.isCompleted ? Colors.green : Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  // ====================== Helper Method to Build Detail Sections ======================
  Widget _buildDetailSection({
    required IconData icon,
    required String title,
    required String content,
    bool isScrollable = false,
    Color? contentColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFbfdee9),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF063454), size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: const Color(0xFF063454),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                isScrollable
                    ? SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Text(
                        content,
                        style: TextStyle(
                          color:
                              contentColor ??
                              const Color(0xFF063454).withOpacity(0.8),
                          fontSize: 14,
                        ),
                      ),
                    )
                    : Text(
                      content,
                      style: TextStyle(
                        color:
                            contentColor ??
                            const Color(0xFF063454).withOpacity(0.8),
                        fontSize: 14,
                      ),
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
