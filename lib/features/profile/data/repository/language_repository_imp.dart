import 'package:flutter/material.dart';

import '../../profile.dart';

class LanguageRepositoryImp implements LanguageRepository {
  LanguageRepositoryImp({required LanguageLocalDataSource localDataSource})
      : _localDataSource = localDataSource;

  final LanguageLocalDataSource _localDataSource;

  @override
  LanguageEntity getLanguage() {
    return _localDataSource.getLanguage();
  }

  @override
  Future<void> saveLanguage(LanguageEntity language) {
    return _localDataSource.saveLanguage(language);
  }
}
