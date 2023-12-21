import 'package:equatable/equatable.dart';
import '../../../profile.dart';

abstract class LanguageState extends Equatable {
  const LanguageState(this.language);

  final LanguageEntity language;

  @override
  List<Object?> get props => [language];
}

class LanguageLoadSuccess extends LanguageState {
  const LanguageLoadSuccess(LanguageEntity language) : super(language);
}
