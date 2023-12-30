import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../lib.dart';

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
              create: (context) => sl()..add(ThemeStarted())),
          BlocProvider<LoginCubit>(create: (context) => sl())
        ],
        child: Builder(
          builder: (context) {
            final locale = context.watch<LanguageBloc>().state.language.locale;
            final themeMode = context.watch<ThemeBloc>().state.theme.mode;
            return MaterialApp.router(
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: locale,
              debugShowCheckedModeBanner: false,
              onGenerateTitle: (context) =>
                  AppLocalizations.of(context)!.appName,
              theme: lightTheme(),
              darkTheme: darkTheme(),
              themeMode: themeMode,
              routerConfig: router,
            );
          },
        ),
      ),
    );
  }
}
