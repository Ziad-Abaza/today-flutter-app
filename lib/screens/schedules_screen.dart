import 'package:flutter/material.dart';
import 'package:myapp/screens/schedule_form_screen.dart';
import 'package:provider/provider.dart';
import 'package:myapp/widget/header_app.dart';
import 'package:myapp/widget/schedule_list.dart';
import 'package:myapp/widget/navigation_bar.dart';
import 'package:myapp/providers/schedule_provider.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheduleProvider = Provider.of<ScheduleProvider>(context);

    scheduleProvider.loadSchedules();

    return Scaffold(
      backgroundColor: const Color(0xFF468ca3),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ====================== Section 1 ======================
              HeaderApp(),

              const SizedBox(height: 20),

              // ====================== Section 2 ======================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Scheduled Tasks",
                    style: const TextStyle(
                      color: Color(0xFFbfdee9),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                    ),
                  ),
                  FloatingActionButton.small(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ScheduleFormScreen(),
                        ),
                      );
                    },
                    backgroundColor: const Color(0xFF063454),
                    elevation: 4,
                    child: const Icon(
                      Icons.add,
                      size: 18,
                      color: Color(0xFFbfdee9),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              // ====================== Section 3 ======================
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                    color: const Color(0xFFbfdee9),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child:
                      scheduleProvider.schedules.isEmpty
                          ? const Center(
                            child: Text(
                              "No scheduled tasks available",
                              style: TextStyle(
                                color: Color(0xFF063454),
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                          : ScheduleList(),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavigationButtom(currentIndex: 1),
    );
  }
}
