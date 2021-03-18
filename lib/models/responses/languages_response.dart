import 'package:json_annotation/json_annotation.dart';

import '../language.dart';

part 'languages_response.g.dart';

@JsonSerializable()
class LanguagesResponse {
  LanguagesResponse(Map<String, dynamic> data)
      : this.data = List.generate(data['languages'].length,
            (index) => Language.fromJson(data["languages"][index]));

  factory LanguagesResponse.fromJson(Map<String, dynamic> json) =>
      _$LanguagesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LanguagesResponseToJson(this);

  @override
  @JsonKey(name: 'data')
  final List<Language> data;
}
