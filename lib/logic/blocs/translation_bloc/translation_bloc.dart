import 'package:chopper/chopper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernova_translator/logic/blocs/languages_bloc/languages_bloc.dart';
import 'package:supernova_translator/logic/blocs/translation_bloc/translation_event.dart';
import 'package:supernova_translator/logic/blocs/translation_options_bloc/translation_options.dart';
import 'package:supernova_translator/logic/services/google_translate_api_service.dart';
import 'package:supernova_translator/models/dto/translation.dart';
import 'package:supernova_translator/models/responses/translation_response.dart';

import 'loading/loading_translation_bloc.dart';

class TranslationBloc extends Bloc<TranslationEvent, List<Translation>> {
  TranslationBloc(this._translateApiService, this._languagesBloc)
      : super(<Translation>[]);

  GoogleTranslateApiService _translateApiService;
  LanguagesBloc _languagesBloc;

  void getTranslation(TranslationOptions options) =>
      add(GetTranslation(options));

  void cleanTranslation() => add(CleanTranslation());

  bool _loading = false;

  void startLoading() {
    if (!_loading) {
      _loading = true;
      _loadingBloc.setLoading();
    }
  }

  final LoadingTranslationBloc _loadingBloc = LoadingTranslationBloc();

  LoadingTranslationBloc get loadingBloc => _loadingBloc;

  @override
  Stream<List<Translation>> mapEventToState(TranslationEvent event) async* {
    if (event is GetTranslation) {
      _loadingBloc.setLoading();

      _loading = true;
      List<Translation> _translations = <Translation>[];

      Response<TranslationResponse> response = await _translateApiService
          .translateText(event.options.initialText, event.options.finalLanguage,
              source: event.options.initialLanguage);

      if (response.isSuccessful) {
        response.body.data.forEach((element) {
          if (element.isDetected) {
            _translations.add(element.copyWith(
                startingLanguage: _languagesBloc
                    .getLanguageFromIso(element.detectedLanguage)));
          } else {
            _translations.add(element);
          }
        });
      }
      _loading = false;
      _loadingBloc.setLoading(loading: false);
      yield (_translations);
    } else if (event is CleanTranslation) {
      yield ([]);
    }
  }
}
