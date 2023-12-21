import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:settings_ui/settings_ui.dart';
import '../../profile.dart';

class ThemePage extends StatelessWidget {
  const ThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.theme)),
      body: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
        return SettingsList(sections: [
          SettingsSection(
            title: Text(AppLocalizations.of(context)!.theme),
            tiles: _buildLanguageTiles(context, state.theme),
          )
        ]);
      }),
    );
  }

  List<SettingsTile> _buildLanguageTiles(
    BuildContext context,
    ThemeEntity selectedTheme,
  ) {
    return ThemeEntity.themes
        .map<SettingsTile>(
          (theme) => SettingsTile(
            title: Text((() {
              switch (theme.mode) {
                case ThemeMode.light:
                  return AppLocalizations.of(context)!.light;
                case ThemeMode.dark:
                  return AppLocalizations.of(context)!.dark;
                default:
                  return AppLocalizations.of(context)!.system;
              }
            }())),
            onPressed: (context) {
              context.read<ThemeBloc>().add(ThemeChanged(theme: theme));
            },
            leading: Radio<ThemeEntity>(
              value: theme,
              groupValue: selectedTheme,
              onChanged: (selectedLanguage) {
                context.read<ThemeBloc>().add(ThemeChanged(theme: theme));
              },
            ),
          ),
        )
        .toList();
  }
}
