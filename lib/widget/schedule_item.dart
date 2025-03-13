import 'package:flutter/material.dart';
import 'package:myapp/database/schedule_model.dart';
import 'package:myapp/providers/schedule_provider.dart';
import 'package:myapp/screens/schedule_details_screen.dart';
import 'package:provider/provider.dart';

class scheduleItem extends StatelessWidget {
  const scheduleItem({super.key, required this.schedule});

  final Schedule schedule;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        schedule.title,
        style: const TextStyle(
          color: Color(0xFF063454),
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        "Date: ${schedule.date} - ${schedule.time}",
        style: TextStyle(color: Colors.grey[600], fontSize: 14),
      ),
      trailing: Checkbox(
        value: schedule.isEnabled,
        onChanged: (value) {
          Provider.of<ScheduleProvider>(
            context,
            listen: false,
          ).toggleScheduleStatus(schedule.id!, value ?? false);
        },
        activeColor: const Color(0xFF063454),
      ),

      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => ScheduleDetailsScreen(scheduleId: schedule.id!),
          ),
        );
      },
    );
  }
}
