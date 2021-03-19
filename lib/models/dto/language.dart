import 'package:json_annotation/json_annotation.dart';

part 'language.g.dart';

@JsonSerializable()
class Language {
  const Language({this.iso, this.name});

  factory Language.fromJson(Map<String, dynamic> json) =>
      _$LanguageFromJson(json);

  Map<String, dynamic> toJson() => _$LanguageToJson(this);

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'language')
  final String iso;
}
