import 'package:flutter/material.dart';
import 'package:myapp/database/schedule_model.dart';
import 'package:myapp/providers/schedule_provider.dart';
import 'package:provider/provider.dart';

class ScheduleDetailsScreen extends StatelessWidget {
  final int scheduleId;

  const ScheduleDetailsScreen({super.key, required this.scheduleId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<Schedule?>(
          future: Provider.of<ScheduleProvider>(context, listen: false).getSchedule(scheduleId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text(
                "Loading...",
                style: TextStyle(
                  color: Color(0xFFbfdee9),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              );
            } else if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
              return Text(
                "Schedule Details",
                style: TextStyle(
                  color: Color(0xFFbfdee9),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              );
            }

            final schedule = snapshot.data!;
            return Text(
              schedule.title,
              style: TextStyle(
                color: Color(0xFFbfdee9),
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            );
          },
        ),
        backgroundColor: const Color(0xFF063454),
        elevation: 4,
      ),
      body: FutureBuilder<Schedule?>(
        future: Provider.of<ScheduleProvider>(context, listen: false).getSchedule(scheduleId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("Schedule not found"));
          }

          final schedule = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ====================== Description Section ======================
                _buildDetailSection(
                  icon: Icons.description,
                  title: "Description",
                  content: schedule.description.isNotEmpty ? schedule.description : "No description provided",
                  isScrollable: true,
                ),
                const SizedBox(height: 15),

                // ====================== Date Section ======================
                _buildDetailSection(
                  icon: Icons.calendar_today,
                  title: "Date",
                  content: schedule.date,
                ),
                const SizedBox(height: 15),

                // ====================== Time Section ======================
                _buildDetailSection(
                  icon: Icons.access_time,
                  title: "Time",
                  content: schedule.time,
                ),
                const SizedBox(height: 15),

                // ====================== Status Section ======================
                _buildDetailSection(
                  icon: Icons.check_circle_outline,
                  title: "Status",
                  content: schedule.isEnabled ? "Enabled" : "Disabled",
                  contentColor: schedule.isEnabled ? Colors.green : Colors.red,
                ),
              ],
            ),
          );
        },
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
                            color: contentColor ?? const Color(0xFF063454).withOpacity(0.8),
                            fontSize: 14,
                          ),
                        ),
                      )
                    : Text(
                        content,
                        style: TextStyle(
                          color: contentColor ?? const Color(0xFF063454).withOpacity(0.8),
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