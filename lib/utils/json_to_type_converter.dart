import 'dart:convert';

import 'package:chopper/chopper.dart';

/// Boilerplate class to manage achieve type-safe endpoints when
/// working with Chopper clients

class JsonToTypeConverter extends JsonConverter {
  final Map<Type, Function> typeToJsonFactoryMap;

  JsonToTypeConverter(this.typeToJsonFactoryMap);

  @override
  Response<BodyType> convertResponse<BodyType, InnerType>(Response response) {
    return response.copyWith(
      body: fromJsonData<BodyType, InnerType>(
          response.body, typeToJsonFactoryMap[InnerType]),
    );
  }

  T fromJsonData<T, InnerType>(String jsonData, Function jsonParser) {
    if (jsonData.isEmpty) {
      jsonData = '{}';
    }
    var jsonMap = json.decode(jsonData);

    if (jsonParser != null) {
      if (jsonMap is List) {
        return jsonMap
            .map(
                (item) => jsonParser(item as Map<String, dynamic>) as InnerType)
            .toList() as T;
      }
      return jsonParser(jsonMap);
    }

    return jsonMap;
  }
}
