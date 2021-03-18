import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'language.dart';

part 'translation.g.dart';

@JsonSerializable()
class Translation extends Equatable {
  Translation(
      {this.startingLanguage,
      this.startingText,
      this.finalLanguage,
      this.finalText});

  factory Translation.fromJson(Map<String, dynamic> json) =>
      _$TranslationFromJson(json);

  Map<String, dynamic> toJson() => _$TranslationToJson(this);

  @override
  List<Object> get props =>
      [startingText, startingLanguage, finalText, finalLanguage];

  @JsonKey(name: 'startingText')
  String startingText;

  @JsonKey(name: 'startingLanguage')
  Language startingLanguage;

  @JsonKey(name: 'finalText')
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
