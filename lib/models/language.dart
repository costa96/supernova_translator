import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'language.g.dart';

@JsonSerializable()
class Language extends Equatable {
  Language({this.ISO, this.name});

  factory Language.fromJson(Map<String, dynamic> json) =>
      _$LanguageFromJson(json);

  Map<String, dynamic> toJson() => _$LanguageToJson(this);

  @override
  List<Object> get props => [name, ISO];

  @JsonKey(name: 'id')
  final String name;

  @JsonKey(name: 'id')
  final String ISO;
}
