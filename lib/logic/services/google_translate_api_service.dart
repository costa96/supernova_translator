import 'package:chopper/chopper.dart';
import 'package:supernova_translator/models/responses/languages_response.dart';
import 'package:supernova_translator/utils/constants.dart';

part 'google_translate_api_service.chopper.dart';

@ChopperApi(baseUrl: API_TRANSLATION_SERVICE)
abstract class GoogleTranslateApiService extends ChopperService {
  static GoogleTranslateApiService create([ChopperClient client]) {
    return _$GoogleTranslateApiService(client);
  }

  @Get(path: LANGUAGES_ENDPOINT)
  Future<Response<LanguagesResponse>> getLanguages(
      {@Query() target = DEFAULT_TARGET});

  @Post(path: TRANSLATE_ENDPOINT)
  Future<Response> translateText(@Query() String q, @Query() String target,
      {@Query() String format = DEFAULT_FORMAT,
      @Query() String source,
      @Query() String model});

  @Post(path: DETECT_ENDPOINT)
  Future<Response> detectLanguage(@Query() String q);
}
