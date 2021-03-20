import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernova_translator/logic/blocs/preferences_bloc/preferences_bloc.dart';
import 'package:supernova_translator/models/dto/translation.dart';
import 'package:supernova_translator/utils/debouncer.dart';

import 'single_preference_event.dart';

class SinglePreferenceBloc extends Bloc<SinglePreferenceEvent, bool> {
  SinglePreferenceBloc(this._preferencesBloc, Translation translation)
      : super(_preferencesBloc.state.contains(translation));

  final PreferencesBloc _preferencesBloc;

  Debouncer _debouncer = Debouncer();

  void toggle(Translation translation) => add(Toggle(translation));

  @override
  Stream<bool> mapEventToState(SinglePreferenceEvent event) async* {
    if (event is Toggle) {
      if (state) {
        _debouncer.call(() {
          _preferencesBloc.removePreference(event.translation);
        });
      } else {
        _debouncer.call(() {
          _preferencesBloc.addPreference(event.translation);
        });
      }

      yield (!state);
    }
  }
}
