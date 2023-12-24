import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:logger/logger.dart';
import 'package:piano_admin/core/core.dart';
import 'package:piano_admin/features/authentication/presentation/bloc/login/login_cubit.dart';
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
    logger.d('redirect ${state.matchedLocation} authState $authState');
    if (authState.status == AuthStatus.unauthenticated) {
      if (state.matchedLocation == '/login/signup') {
        return '/login/signup';
      }
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
          path: 'signup',
          builder: (context, state) => const SignUpPage(),
        ),
      ],
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
                create: (context) => sl()..add(LanguageStarted())),
            BlocProvider<ThemeBloc>(
                create: (context) => sl()..add(ThemeStarted()))
          ],
          child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
            logger.d('Auth bloc builder $state');
            return BlocBuilder<LanguageBloc, LanguageState>(
                builder: (context, languageState) {
              return BlocBuilder<ThemeBloc, ThemeState>(
                  builder: (context, themeState) {
                return MaterialApp.router(
                  localizationsDelegates:
                      AppLocalizations.localizationsDelegates,
                  supportedLocales: AppLocalizations.supportedLocales,
                  locale: languageState.language.locale,
                  debugShowCheckedModeBanner: false,
                  onGenerateTitle: (context) =>
                      AppLocalizations.of(context)!.appName,
                  theme: lightTheme(),
                  darkTheme: darkTheme(),
                  themeMode: themeState.theme.mode,
                  routerConfig: _router,
                );
              });
            });
          })),
    );
  }
}
