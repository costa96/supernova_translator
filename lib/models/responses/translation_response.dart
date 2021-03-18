import 'package:json_annotation/json_annotation.dart';

import '../translation.dart';

part 'translation_response.g.dart';

@JsonSerializable()
class TranslationResponse {
  TranslationResponse(Map<String, dynamic> data)
      : this.data = List.generate(data['translations'].length,
            (index) => Translation.fromJson(data["translations"][index]));

  factory TranslationResponse.fromJson(Map<String, dynamic> json) =>
      _$TranslationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TranslationResponseToJson(this);

  @override
  @JsonKey(name: 'data')
  List<Translation> data;
}
