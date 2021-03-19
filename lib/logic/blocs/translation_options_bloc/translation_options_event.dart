import 'package:supernova_translator/models/dto/language.dart';

import 'translation_options.dart';

abstract class TranslationOptionsEvent {}

class SetOptions extends TranslationOptionsEvent {
  SetOptions(this.options);
  final TranslationOptions options;
}

class SetInitialLanguage extends TranslationOptionsEvent {
  SetInitialLanguage(this.language);
  final Language language;
}

class SetFinalLanguage extends TranslationOptionsEvent {
  SetFinalLanguage(this.language);
  final Language language;
}

class SetInitialText extends TranslationOptionsEvent {
  SetInitialText(this.text);
  final String text;
}

class SwapLanguages extends TranslationOptionsEvent {}
