import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:supernova_translator/logic/services/google_translate_api_service.dart';
import 'package:supernova_translator/models/language.dart';
import 'package:supernova_translator/models/responses/languages_response.dart';

import '../constants.dart' as global;
import '../constants.dart';
import '../json_to_type_converter.dart';

class TranslationClient {
  TranslationClient() {
    _client = ChopperClient(
      baseUrl: global.GOOGLE_TRANSLATE_API_BASE_URL,
      services: [
        GoogleTranslateApiService.create(),
      ],
      interceptors: [KeyInterceptor()],
      converter: JsonToTypeConverter(converters),
      errorConverter: JsonConverter(),
    );
  }

  ChopperClient _client;

  ChopperClient get client => _client;

  static Map<Type, Function> converters = {
    Language: (jsonData) => Language.fromJson(jsonData),
    LanguagesResponse: (jsonData) => LanguagesResponse.fromJson(jsonData),
  };
}

class KeyInterceptor implements RequestInterceptor {
  @override
  FutureOr<Request> onRequest(Request request) {
    final params = Map<String, dynamic>.from(request.parameters);
    params['key'] = GOOGLE_API_KEY;
    return request.copyWith(parameters: params);
  }
}
