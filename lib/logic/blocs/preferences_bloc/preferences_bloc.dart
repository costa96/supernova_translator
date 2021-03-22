import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernova_translator/logic/services/preferences.dart';
import 'package:supernova_translator/models/dto/translation.dart';
import 'package:supernova_translator/utils/debouncer.dart';

import 'preferences_event.dart';

class PreferencesBloc extends Bloc<PreferencesEvent, List<Translation>> {
  PreferencesBloc() : super([]) {
    loadPreferences();
  }

  void addPreference(Translation translation) =>
      add(AddPreference(translation));

  void removePreference(Translation translation) =>
      add(RemovePreference(translation));

  void loadPreferences() => add(LoadPreferences());

  Preferences preferences = Preferences();

  Debouncer _debouncer = Debouncer();

  @override
  Stream<List<Translation>> mapEventToState(PreferencesEvent event) async* {
    if (event is LoadPreferences) {
      List<Translation> saved = await preferences.loadFavoriteTranslation();
      yield (saved);
    } else if (event is AddPreference) {
      if (!state.contains(event.translation)) {
        List<Translation> _newList = List<Translation>.from(state);
        _newList.add(event.translation);
        yield (_newList);

        _debouncer.call(
            () async => await preferences.saveFavoriteTranslations(_newList));
      }
    } else if (event is RemovePreference) {
      if (state.contains(event.translation)) {
        List<Translation> _newList = List<Translation>.from(state);
        _newList.remove(event.translation);
        yield (_newList);
        _debouncer.call(
            () async => await preferences.saveFavoriteTranslations(_newList));
      }
    }
  }
}
