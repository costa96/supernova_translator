import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernova_translator/models/dto/translation.dart';

import 'preferences_event.dart';

class PreferencesBloc extends Bloc<PreferencesEvent, List<Translation>> {
  PreferencesBloc() : super([]);

  void addPreference(Translation translation) =>
      add(AddPreference(translation));

  void removePreference(Translation translation) =>
      add(RemovePreference(translation));

  void loadPreferences() => add(LoadPreferences());

  @override
  Stream<List<Translation>> mapEventToState(PreferencesEvent event) async* {
    if (event is LoadPreferences) {
      //Call shared prefs
    } else if (event is AddPreference) {
      if (!state.contains(event.translation)) {
        List<Translation> _newList = List<Translation>.from(state);
        _newList.add(event.translation);
        //save in shared
        yield (_newList);
        print(_newList);
      }
    } else if (event is RemovePreference) {
      if (state.contains(event.translation)) {
        List<Translation> _newList = List<Translation>.from(state);
        _newList.remove(event.translation);
        //save in shared
        yield (_newList);

        print(_newList);
      }
    }
  }
}
