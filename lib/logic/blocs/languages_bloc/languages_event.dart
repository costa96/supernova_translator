import 'package:supernova_translator/utils/constants.dart';

abstract class LanguagesEvent {}

class GetLanguages extends LanguagesEvent {
  GetLanguages({this.target = DEFAULT_TARGET});

  final String target;
}
