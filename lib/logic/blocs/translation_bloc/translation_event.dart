import 'package:supernova_translator/models/dto/translation.dart';

abstract class TranslationEvent {}

class GetTranslation extends TranslationEvent {
  GetTranslation(this.translation);
  final Translation translation;
}
