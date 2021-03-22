import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernova_translator/logic/blocs/translation_bloc/translation_bloc.dart';
import 'package:supernova_translator/models/dto/language.dart';
import 'package:supernova_translator/utils/debouncer.dart';

import 'translation_options.dart';
import 'translation_options_event.dart';

class TranslationOptionsBloc
    extends Bloc<TranslationOptionsEvent, TranslationOptions> {
  TranslationOptionsBloc(this._translationBloc)
      : super(TranslationOptions(initialLanguage: Language.detect()));

  TranslationBloc _translationBloc;

  void setOptions(TranslationOptions options) => add(SetOptions(options));

  void setInitialLanguage(Language language) =>
      add(SetInitialLanguage(language));

  void setFinalLanguage(Language language) => add(SetFinalLanguage(language));

  void setStartingText(String text) => add(SetInitialText(text));

  void swapLanguages() => add(SwapLanguages());
  Debouncer _debouncer = Debouncer();

  @override
  Stream<TranslationOptions> mapEventToState(
      TranslationOptionsEvent event) async* {
    if (event is SetOptions) {
      yield (event.options);
    } else if (event is SetInitialLanguage) {
      yield (state.copyWith(initialLanguage: event.language));
    } else if (event is SetFinalLanguage) {
      yield (state.copyWith(finalLanguage: event.language));
    } else if (event is SetInitialText) {
      yield (state.copyWith(initialText: event.text));
    } else if (event is SwapLanguages) {
      /// If initial language is Language.detect() then the final one must be
      /// set as null, .copyWith(finalLanguage: null) doesn't bring the
      /// expected result, 'cause it ignores the parameter and keeps the old
      /// one. This is just an hacky way to fix the problem. There are many ways
      /// to solve it, but most of them are way too verbose and create
      /// complexity in the code. From my prospective this is the right middle
      /// ground to keep it clean and achieve the functionality.

      if (state.initialLanguage != Language.detect()) {
        yield (state.copyWith(
            initialLanguage: state.finalLanguage ?? Language.detect(),
            finalLanguage: state.initialLanguage));
      } else {
        TranslationOptions _newOptions = TranslationOptions(
            initialLanguage: state.finalLanguage ?? Language.detect(),
            initialText: state.initialText);
        yield (_newOptions);
      }
    }

    if (state.isSearchable()) {
      _translationBloc.startLoading();

      _debouncer(() => _translationBloc.getTranslation(state));
    } else {
      _translationBloc.cleanTranslation();
    }
  }
}
