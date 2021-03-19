import 'package:supernova_translator/logic/blocs/translation_options_bloc/translation_options.dart';

abstract class TranslationEvent {}

class GetTranslation extends TranslationEvent {
  GetTranslation(this.options);
  final TranslationOptions options;
}
