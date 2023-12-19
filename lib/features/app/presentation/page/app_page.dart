import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/config.dart';
import '../../../../injection_container.dart';
import '../../../authentication/authentication.dart';
import '../../../bill/bill.dart';
import '../../../home/home.dart';
import '../../../notification/notification.dart';
import '../../../people/people.dart';
import '../../../profile/profile.dart';
import '../../../schedule/schedule.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

final _router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  redirect: (context, state) {
    final authState = context.read<AuthBloc>().state;
    if (authState.status == AuthStatus.authenticated) {
      return '/login';
    }

    // if the user is logged in but still on the login page, send them to
    // the home page
    if (state.matchedLocation == '/login') {
      return '/schedule';
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
        ),
        GoRoute(
          path: '/notification',
          builder: (context, state) => const NotificationPage(),
        ),
      ],
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
  ],
);

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppView();
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => sl(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(lazy: false, create: (context) => sl())
        ],
        child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Piano Admin',
            theme: theme(),
            routerConfig: _router,
          );
        }),
      ),
    );
  }
}
