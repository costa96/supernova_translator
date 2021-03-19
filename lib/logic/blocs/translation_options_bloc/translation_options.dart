import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:supernova_translator/models/dto/language.dart';

part 'translation_options.g.dart';

@CopyWith()
class TranslationOptions {
  TranslationOptions(
      {this.finalLanguage, this.initialLanguage, this.initialText});

  Language initialLanguage;
  Language finalLanguage;
  String initialText;
}
