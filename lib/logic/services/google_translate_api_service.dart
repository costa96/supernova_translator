import 'package:chopper/chopper.dart';
import 'package:supernova_translator/models/language.dart';
import 'package:supernova_translator/models/responses/languages_response.dart';
import 'package:supernova_translator/models/responses/translation_response.dart';
import 'package:supernova_translator/models/translation.dart';
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
  Future<Response<TranslationResponse>> _translateText(
      @Query() String q, @Query() String target,
      {@Query() String format = DEFAULT_FORMAT,
      @Query() String source,
      @Query() String model});

  @Post(path: DETECT_ENDPOINT)
  Future<Response> detectLanguage(@Query() String q);

  // Future<List<Language>> _getLanguages({@Query() target}) async {
  //   Response<LanguagesResponse> response = await _getLanguages(target: target);
  //   return response.body.data;
  // }

  Future<Response<TranslationResponse>> translateText(
      @Query() String q, @Query() Language target,
      {@Query() String format,
      @Query() String source,
      @Query() String model}) async {
    Response<TranslationResponse> response = await _translateText(q, target.iso,
        format: format, source: source, model: model);

    List<Translation> _translation = response.body.data;

    _translation
        .map((e) => e
          ..startingText = q
          ..finalLanguage = target
          ..startingLanguage = source ?? e.startingLanguage)
        .toList();
    return response.copyWith(body: response.body..data = _translation);
  }
}
