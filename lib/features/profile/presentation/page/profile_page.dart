import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:piano_admin/features/authentication/authentication.dart';
import 'package:piano_admin/features/profile/profile.dart';
import 'package:settings_ui/settings_ui.dart';

import '../widget/adaptive_action.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, authState) {
        if (authState.status == AuthStatus.unauthenticated) {
          context.go('/login');
        }
      },
      builder: (context, authState) {
        return BlocBuilder<LanguageBloc, LanguageState>(
            builder: (context, languageState) {
          return BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, themeState) {
            return SettingsList(sections: [
              SettingsSection(
                title: Text(AppLocalizations.of(context)!.account),
                tiles: [
                  SettingsTile(
                    leading: const Icon(Icons.person_2_outlined),
                    title: Text(AppLocalizations.of(context)!.userName),
                    value: Text(authState.user.name ?? ''),
                  ),
                  SettingsTile(
                    leading: const Icon(Icons.email_outlined),
                    title: Text(AppLocalizations.of(context)!.email),
                    value: Text(authState.user.email ?? ''),
                  ),
                  SettingsTile(
                    leading: const Icon(Icons.phone_android_outlined),
                    title: Text(AppLocalizations.of(context)!.phoneNumber),
                    value: Text(authState.user.phone ?? ''),
                  ),
                  SettingsTile.navigation(
                    leading: const Icon(Icons.password_outlined),
                    title: Text(AppLocalizations.of(context)!.password),
                    onPressed: (context) => context.go('/profile/password'),
                  ),
                ],
              ),
              SettingsSection(
                title: Text(AppLocalizations.of(context)!.settings),
                tiles: [
                  SettingsTile.navigation(
                    leading: const Icon(Icons.contrast_outlined),
                    title: Text(AppLocalizations.of(context)!.theme),
                    value: Text((() {
                      switch (themeState.theme.mode) {
                        case ThemeMode.light:
                          return AppLocalizations.of(context)!.light;
                        case ThemeMode.dark:
                          return AppLocalizations.of(context)!.dark;
                        default:
                          return AppLocalizations.of(context)!.system;
                      }
                    }())),
                    onPressed: (context) => context.go('/profile/theme'),
                  ),
                  SettingsTile.navigation(
                    leading: const Icon(Icons.translate_outlined),
                    title: Text(AppLocalizations.of(context)!.language),
                    value: Text(languageState.language.nativeValue),
                    onPressed: (context) => context.go('/profile/language'),
                  )
                ],
              ),
              SettingsSection(
                title: Text(AppLocalizations.of(context)!.logOut),
                tiles: [
                  SettingsTile(
                    leading: const Icon(Icons.logout_outlined),
                    title: Text(AppLocalizations.of(context)!.logOut),
                    onPressed: (context) {
                      showAdaptiveDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog.adaptive(
                            title: Text(AppLocalizations.of(context)!.logOut),
                            content: Text(
                                AppLocalizations.of(context)!.confirmLogOut),
                            actions: [
                              adaptiveAction(
                                context: context,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child:
                                    Text(AppLocalizations.of(context)!.cancel),
                              ),
                              adaptiveAction(
                                context: context,
                                onPressed: () => context
                                    .read<AuthBloc>()
                                    .add(const AuthLogoutRequested()),
                                child:
                                    Text(AppLocalizations.of(context)!.logOut),
                              )
                            ],
                          );
                        },
                      );
                    },
                  )
                ],
              )
            ]);
          });
        });
      },
    );
  }
}
