import 'package:chopper/chopper.dart';
import 'package:supernova_translator/models/responses/languages_response.dart';
import 'package:supernova_translator/utils/constants.dart';

part 'google_translate_api_service.chopper.dart';

@ChopperApi(baseUrl: API_TRANSLATION_SERVICE)
abstract class GoogleTranslateApiService extends ChopperService {
  @Get(path: LANGUAGES_ENDPOINT)
  Future<Response<LanguagesResponse>> getLanguages({@Query() target = "en"});

  static GoogleTranslateApiService create([ChopperClient client]) {
    return _$GoogleTranslateApiService(client);
  }
}
