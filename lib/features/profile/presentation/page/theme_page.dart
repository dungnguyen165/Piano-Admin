import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:settings_ui/settings_ui.dart';
import '../../profile.dart';

class ThemePage extends StatelessWidget {
  const ThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.theme)),
      body: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
        return SettingsList(sections: [
          SettingsSection(
            title: Text(l10n.theme),
            tiles: _buildLanguageTiles(context, l10n, state.theme),
          )
        ]);
      }),
    );
  }

  List<SettingsTile> _buildLanguageTiles(
    BuildContext context,
    AppLocalizations l10n,
    ThemeEntity selectedTheme,
  ) {
    return ThemeEntity.themes
        .map<SettingsTile>(
          (theme) => SettingsTile(
            title: Text((() {
              switch (theme.mode) {
                case ThemeMode.light:
                  return l10n.light;
                case ThemeMode.dark:
                  return l10n.dark;
                default:
                  return l10n.system;
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
