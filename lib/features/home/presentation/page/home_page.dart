import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../lib.dart';

class HomePage extends StatefulWidget {
  const HomePage({required this.child, super.key});

  final Widget child;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocProvider<HomeCubit>(
      create: (context) => sl(),
      child: Builder(builder: (context) {
        return BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            switch (state.tab) {
              case HomeTab.schedule:
                GoRouter.of(context).go('/');
              case HomeTab.bill:
                GoRouter.of(context).go('/bill');
              case HomeTab.people:
                GoRouter.of(context).go('/people');
              case HomeTab.profile:
                GoRouter.of(context).go('/profile');
            }
          },
          builder: (context, state) {
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
                      icon: const Icon(Icons.schedule_outlined),
                      label: l10n.schedule),
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.payment_outlined),
                      label: l10n.bill),
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.people_outline),
                      label: l10n.people),
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.settings_outlined),
                      label: l10n.profile),
                ],
                currentIndex: state.tab.index,
                unselectedItemColor: Colors.black,
                selectedItemColor: Colors.pink,
                onTap: (index) {
                  context.read<HomeCubit>().setTab(HomeTab.values[index]);
                },
              ),
            );
          },
        );
      }),
    );
  }
}
