import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:myapp/database/schedule_model.dart';
import 'package:myapp/providers/schedule_provider.dart';
import 'package:myapp/screens/schedule_details_screen.dart';
import 'package:myapp/screens/schedule_form_screen.dart';
import 'package:myapp/widget/schedule_item.dart';
import 'package:provider/provider.dart';

class ScheduleList extends StatefulWidget {
  const ScheduleList({super.key});

  @override
  State<ScheduleList> createState() => _ScheduleListState();
}

class _ScheduleListState extends State<ScheduleList> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () =>
          Provider.of<ScheduleProvider>(context, listen: false).loadSchedules(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ScheduleProvider>(
      builder: (context, provider, child) {
        final schedules = provider.schedules;

        if (schedules.isEmpty) {
          return const Center(
            child: Text(
              "No scheduled tasks available",
              style: TextStyle(
                color: Color(0xFF063454),
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }

        return ListView.builder(
          itemCount: schedules.length,
          itemBuilder: (context, index) {
            final schedule = schedules[index];

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
                              (context) => ScheduleFormScreen(
                                scheduleId: schedule.id.toString(),
                              ),
                        ),
                      );
                    },
                    backgroundColor: const Color(0xFFbfdee9),
                    icon: Icons.edit,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  SlidableAction(
                    onPressed: (context) {
                      provider.deleteSchedule(schedule.id!);
                    },
                    backgroundColor: Color(0xFFbfdee9),
                    icon: Icons.delete,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ],
              ),
              child: scheduleItem(schedule: schedule),
            );
          },
        );
      },
    );
  }
}
