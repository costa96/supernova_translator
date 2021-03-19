import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

import 'language.dart';

part 'translation.g.dart';

@CopyWith()
@JsonSerializable()
class Translation {
  Translation(
      {this.startingLanguage,
      this.startingText,
      this.finalLanguage,
      this.finalText,
      this.detectedLanguage});

  factory Translation.fromJson(Map<String, dynamic> json) =>
      _$TranslationFromJson(json);

  Map<String, dynamic> toJson() => _$TranslationToJson(this);

  @JsonKey(name: 'startingText')
  String startingText;

  @JsonKey(name: 'detectedSourceLanguage')
  String detectedLanguage;

  @JsonKey(name: 'startingLanguage')
  Language startingLanguage;

  @JsonKey(name: 'translatedText')
  String finalText;

  @JsonKey(name: 'finalLanguage')
  Language finalLanguage;

  bool get isDetected => detectedLanguage != null;

  swap() {
    Language _startingL = startingLanguage;
    startingLanguage = finalLanguage;
    finalLanguage = _startingL;

    String _startingT = startingText;
    startingText = finalText;
    finalText = _startingT;
  }
}
