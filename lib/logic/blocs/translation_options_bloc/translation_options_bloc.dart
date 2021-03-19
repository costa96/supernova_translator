import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernova_translator/logic/blocs/translation_bloc/translation_bloc.dart';
import 'package:supernova_translator/models/dto/language.dart';

import 'translation_options.dart';
import 'translation_options_event.dart';

class TranslationOptionsBloc
    extends Bloc<TranslationOptionsEvent, TranslationOptions> {
  TranslationOptionsBloc(this._translationBloc) : super(TranslationOptions());

  TranslationBloc _translationBloc;

  void setInitialLanguage(Language language) =>
      add(SetInitialLanguage(language));

  void setFinalLanguage(Language language) => add(SetFinalLanguage(language));

  void setStartingText(String text) => add(SetInitialText(text));

  void swapLanguages() => add(SwapLanguages());

  @override
  Stream<TranslationOptions> mapEventToState(
      TranslationOptionsEvent event) async* {
    if (event is SetInitialLanguage) {
      yield (state.copyWith(initialLanguage: event.language));
    } else if (event is SetFinalLanguage) {
      yield (state.copyWith(finalLanguage: event.language));
    } else if (event is SetInitialText) {
      yield (state.copyWith(initialText: event.text));
    } else if (event is SwapLanguages) {
      yield (state.copyWith(
          initialLanguage: state.finalLanguage,
          finalLanguage: state.initialLanguage));
    }

    if (state.isSearchable()) {
      _translationBloc.getTranslation(state);
    }
  }
}
