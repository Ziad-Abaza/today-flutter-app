import 'package:flutter/material.dart';

class NavigationButtom extends StatelessWidget {
  final int currentIndex;

  const NavigationButtom({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFF063454),
      selectedItemColor: const Color(0xFF72c9ce),
      unselectedItemColor: const Color(0xFFbfdee9),
      currentIndex: currentIndex,
      onTap: (index) {
        String routeName = index == 0 ? '/home' : '/schedules';

        if (ModalRoute.of(context)?.settings.name != routeName) {
          Navigator.pushReplacementNamed(context, routeName);
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Schedules'),
      ],
    );
  }
}
