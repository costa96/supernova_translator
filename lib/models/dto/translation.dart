import 'package:json_annotation/json_annotation.dart';

import 'language.dart';

part 'translation.g.dart';

@JsonSerializable()
class Translation {
  Translation(
      {this.startingLanguage,
      this.startingText,
      this.finalLanguage,
      this.finalText});

  factory Translation.fromJson(Map<String, dynamic> json) =>
      _$TranslationFromJson(json);

  Map<String, dynamic> toJson() => _$TranslationToJson(this);

  @JsonKey(name: 'startingText')
  String startingText;

  @JsonKey(name: 'detectedSourceLanguage')
  Language startingLanguage;

  @JsonKey(name: 'translatedText')
  String finalText;

  @JsonKey(name: 'finalLanguage')
  Language finalLanguage;

  swap() {
    Language _startingL = startingLanguage;
    startingLanguage = finalLanguage;
    finalLanguage = _startingL;

    String _startingT = startingText;
    startingText = finalText;
    finalText = _startingT;
  }
}
