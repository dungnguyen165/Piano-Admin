import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:piano_admin/features/authentication/authentication.dart';
import 'package:piano_admin/features/profile/profile.dart';
import 'package:settings_ui/settings_ui.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, authState) {
      return BlocBuilder<LanguageBloc, LanguageState>(
          builder: (context, languageState) {
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
              ),
            ],
          ),
          SettingsSection(
            title: Text(AppLocalizations.of(context)!.settings),
            tiles: [
              SettingsTile.navigation(
                leading: const Icon(Icons.contrast_outlined),
                title: Text(AppLocalizations.of(context)!.theme),
                value: Text('Current selected theme'), //TODO: get current theme
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
            title: Text(AppLocalizations.of(context)!.logout),
            tiles: [
              SettingsTile(
                  leading: const Icon(Icons.logout_outlined),
                  title: Text(AppLocalizations.of(context)!.logout))
            ],
          )
        ]);
      });
    });
  }
}
