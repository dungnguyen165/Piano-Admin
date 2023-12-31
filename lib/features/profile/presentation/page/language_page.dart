import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../profile.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.language)),
      body: BlocBuilder<LanguageBloc, LanguageState>(builder: (context, state) {
        return SettingsList(sections: [
          SettingsSection(
            title: Text(l10n.language),
            tiles: _buildLanguageTiles(context, state.language),
          )
        ]);
      }),
    );
  }

  List<SettingsTile> _buildLanguageTiles(
    BuildContext context,
    LanguageEntity selectedLanguage,
  ) {
    return LanguageEntity.languages
        .map<SettingsTile>(
          (language) => SettingsTile(
            title: Text(language.nativeValue),
            value: Text(language.value),
            onPressed: (context) {
              context
                  .read<LanguageBloc>()
                  .add(LanguageChanged(language: language));
            },
            leading: Radio<LanguageEntity>(
              value: language,
              groupValue: selectedLanguage,
              onChanged: (selectedLanguage) {
                context
                    .read<LanguageBloc>()
                    .add(LanguageChanged(language: language));
              },
            ),
          ),
        )
        .toList();
  }
}
