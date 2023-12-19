import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({required this.child, super.key});

  final Widget child;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Piano'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            tooltip: 'Notification',
            onPressed: () {
              context.go('/notification');
            },
          ),
        ],
      ),
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.schedule_outlined), label: 'Schedule'),
          BottomNavigationBarItem(
              icon: Icon(Icons.payment_outlined), label: 'Bill'),
          BottomNavigationBarItem(
              icon: Icon(Icons.people_outline), label: 'People'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined), label: 'Setting'),
        ],
        currentIndex: _currentIndex,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.pink,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          _onItemTapped(index, context);
        },
      ),
    );
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go('/');
        break;
      case 1:
        GoRouter.of(context).go('/bill');
        break;
      case 2:
        GoRouter.of(context).go('/people');
        break;
      case 3:
        GoRouter.of(context).go('/profile');
        break;
    }
  }
}
