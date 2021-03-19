import 'package:chopper/chopper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernova_translator/logic/blocs/translation_bloc/translation_event.dart';
import 'package:supernova_translator/logic/services/google_translate_api_service.dart';
import 'package:supernova_translator/models/dto/translation.dart';
import 'package:supernova_translator/models/responses/translation_response.dart';

class TranslationBloc extends Bloc<TranslationEvent, List<Translation>> {
  TranslationBloc(this._translateApiService) : super(null);

  void getTranslation(Translation translation) =>
      add(GetTranslation(translation));

  GoogleTranslateApiService _translateApiService;

  @override
  Stream<List<Translation>> mapEventToState(TranslationEvent event) async* {
    if (event is GetTranslation) {
      yield (null);

      List<Translation> _translations;

      Response<TranslationResponse> response =
          await _translateApiService.translateText(
              event.translation.startingText,
              event.translation.startingLanguage);

      if (!response.isSuccessful) {
        _translations = <Translation>[];
      } else {
        _translations = response.body.data;
      }

      yield (_translations);
    }
  }
}
