import 'package:chopper/chopper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernova_translator/logic/services/google_translate_api_service.dart';
import 'package:supernova_translator/models/dto/language.dart';
import 'package:supernova_translator/models/responses/languages_response.dart';

import 'bloc.dart';

class LanguagesBloc extends Bloc<LanguagesEvent, List<Language>> {
  LanguagesBloc(this._translateApiService) : super(null) {
    getLanguages();
  }

  void getLanguages() => add(GetLanguages());

  GoogleTranslateApiService _translateApiService;

  @override
  Stream<List<Language>> mapEventToState(LanguagesEvent event) async* {
    if (event is GetLanguages) {
      yield (null);

      List<Language> _languages = <Language>[];

      Response<LanguagesResponse> response =
          await _translateApiService.getLanguages(target: event.target);

      if (response.isSuccessful) {
        _languages = response.body.data;
      }

      yield (_languages);
    }
  }

  getLanguageFromIso(String iso) {
    if ((state == null || state.isEmpty)) {
      getLanguages();
    }
    return state.firstWhere((element) => element.iso == iso);
  }
}
