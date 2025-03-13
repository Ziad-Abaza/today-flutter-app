import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/providers/task_provider.dart';
import 'package:myapp/providers/schedule_provider.dart';
import 'package:myapp/screens/schedules_screen.dart';
import 'package:myapp/screens/tasks_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TaskProvider()),
        ChangeNotifierProvider(create: (context) => ScheduleProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TasksScreen(),
        routes: {
          '/home': (context) => const TasksScreen(),
          '/schedules': (context) => const ScheduleScreen(),
        },
      ),
    );
  }
}
