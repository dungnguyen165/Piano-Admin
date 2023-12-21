import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:piano_admin/features/profile/presentation/page/language_page.dart';
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
          routes: [
            GoRoute(
              parentNavigatorKey: _rootNavigatorKey,
              path: 'password',
              builder: (context, state) => const LanguagePage(),
            ),
            GoRoute(
              parentNavigatorKey: _rootNavigatorKey,
              path: 'theme',
              builder: (context, state) => const LanguagePage(),
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
            BlocProvider<AuthBloc>(create: (context) => sl()),
            BlocProvider<LanguageBloc>(
                create: (context) => sl()..add(LanguageStarted()))
          ],
          child:
              BlocBuilder<AuthBloc, AuthState>(builder: (context, authState) {
            return BlocBuilder<LanguageBloc, LanguageState>(
                builder: (context, languageState) {
              return MaterialApp.router(
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                locale: languageState.language.locale,
                debugShowCheckedModeBanner: false,
                onGenerateTitle: (context) =>
                    AppLocalizations.of(context)!.appName,
                theme: theme(),
                routerConfig: _router,
              );
            });
          })),
    );
  }
}
