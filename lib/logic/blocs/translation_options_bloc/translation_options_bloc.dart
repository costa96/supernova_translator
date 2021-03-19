import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernova_translator/models/dto/language.dart';

import 'translation_options.dart';
import 'translation_options_event.dart';

class TranslationOptionsBloc
    extends Bloc<TranslationOptionsEvent, TranslationOptions> {
  TranslationOptionsBloc() : super(TranslationOptions());

  void setInitialLanguage(Language language) =>
      add(SetInitialLanguage(language));

  void setFinalLanguage(Language language) => add(SetFinalLanguage(language));

  void setStartingText(String text) => add(SetInitialText(text));

  @override
  Stream<TranslationOptions> mapEventToState(
      TranslationOptionsEvent event) async* {
    if (event is SetInitialLanguage) {
      yield (state.copyWith(initialLanguage: event.language));
    } else if (event is SetFinalLanguage) {
      yield (state.copyWith(finalLanguage: event.language));
    } else if (event is SetInitialText) {
      yield (state.copyWith(initialText: event.text));
    }
  }
}
