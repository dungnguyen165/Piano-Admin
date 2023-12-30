import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/core.dart';
import '../../features/features.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  redirect: (context, state) {
    final authState = context.read<AuthBloc>().state;
    logger.d('redirect ${state.matchedLocation} authState $authState');
    if (authState.status == AuthStatus.unauthenticated) {
      if (state.matchedLocation.contains('otp')) {
        return '/login/otp';
      }
      return '/login';
    }

    // if the user is logged in but still on the login page, send them to
    // the home page
    if (state.matchedLocation.contains('/login')) {
      return '/';
    }

    return null;
  },
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      pageBuilder: (BuildContext context, GoRouterState state, Widget child) {
        return NoTransitionPage(child: HomePage(child: child));
      },
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: SchedulePage()),
          routes: [
            GoRoute(
              parentNavigatorKey: _rootNavigatorKey,
              path: 'notification',
              builder: (context, state) => const NotificationPage(),
            )
          ],
        ),
        GoRoute(
          path: '/bill',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: BillPage()),
        ),
        GoRoute(
          path: '/people',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: PeoplePage()),
        ),
        GoRoute(
          path: '/profile',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: ProfilePage()),
          routes: [
            GoRoute(
              parentNavigatorKey: _rootNavigatorKey,
              path: 'password',
              builder: (context, state) => const PasswordPage(),
            ),
            GoRoute(
              parentNavigatorKey: _rootNavigatorKey,
              path: 'theme',
              builder: (context, state) => const ThemePage(),
            ),
            GoRoute(
              parentNavigatorKey: _rootNavigatorKey,
              path: 'language',
              builder: (context, state) => const LanguagePage(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
      routes: [
        GoRoute(
          path: 'otp',
          builder: (context, state) => const OtpPage(),
        ),
      ],
    ),
  ],
);
