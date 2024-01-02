import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appName),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            tooltip: l10n.notification,
            onPressed: () {
              context.go('/notification');
            },
          ),
        ],
      ),
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: const Icon(Icons.schedule_outlined), label: l10n.schedule),
          BottomNavigationBarItem(
              icon: const Icon(Icons.payment_outlined), label: l10n.bill),
          BottomNavigationBarItem(
              icon: const Icon(Icons.people_outline), label: l10n.people),
          BottomNavigationBarItem(
              icon: const Icon(Icons.settings_outlined), label: l10n.profile),
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
