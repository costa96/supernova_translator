import 'package:json_annotation/json_annotation.dart';

import '../language.dart';
import 'list_response.dart';

part 'languages_response.g.dart';

@JsonSerializable()
class LanguagesResponse implements ListResponse<Language> {
  LanguagesResponse({this.data});

  factory LanguagesResponse.fromJson(Map<String, dynamic> json) =>
      _$LanguagesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LanguagesResponseToJson(this);

  @override
  @JsonKey(name: 'data')
  final List<Language> data;
}
