import 'package:equatable/equatable.dart';
import 'package:piano_admin/features/profile/domain/entity/language_entity.dart';

abstract class LanguageState extends Equatable {
  const LanguageState(this.language);

  final LanguageEntity language;

  @override
  List<Object?> get props => [language];
}

class LanguageLoadSuccess extends LanguageState {
  const LanguageLoadSuccess(LanguageEntity language) : super(language);
}
