import 'package:chopper/chopper.dart';

import '../constants.dart' as global;
import '../json_to_type_converter.dart';

class TranslationClient {
  TranslationClient() {
    _client = ChopperClient(
      baseUrl: global.GOOGLE_TRANSLATE_API_BASE_URL,
      services: [],
      interceptors: [],
      converter: JsonToTypeConverter(converters),
      errorConverter: JsonConverter(),
    );
  }

  ChopperClient _client;

  ChopperClient get client => _client;

  static Map<Type, Function> converters = {};
}
