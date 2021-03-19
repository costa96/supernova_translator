import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'language.g.dart';

@JsonSerializable()
class Language extends Equatable {
  const Language({this.iso, this.name});

  factory Language.fromJson(Map<String, dynamic> json) =>
      _$LanguageFromJson(json);

  factory Language.detect() => Language(
        name: "Detect",
      );

  Map<String, dynamic> toJson() => _$LanguageToJson(this);

  @override
  List<Object> get props => [name, iso];

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'language')
  final String iso;
}
