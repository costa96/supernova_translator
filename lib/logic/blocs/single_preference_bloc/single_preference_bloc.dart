import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernova_translator/logic/blocs/preferences_bloc/preferences_bloc.dart';
import 'package:supernova_translator/models/dto/translation.dart';
import 'package:supernova_translator/utils/debouncer.dart';

import 'single_preference_event.dart';

class SinglePreferenceBloc extends Bloc<SinglePreferenceEvent, bool> {
  SinglePreferenceBloc(this._preferencesBloc, this._translation)
      : super(_preferencesBloc.state.contains(_translation));

  final PreferencesBloc _preferencesBloc;
  final Translation _translation;

  Debouncer _debouncer = Debouncer();

  void toggle() => add(Toggle());

  @override
  Stream<bool> mapEventToState(SinglePreferenceEvent event) async* {
    if (event is Toggle) {
      if (state) {
        _debouncer.call(() {
          _preferencesBloc.removePreference(_translation);
        });
      } else {
        _debouncer.call(() {
          _preferencesBloc.addPreference(_translation);
        });
      }

      yield (!state);
    }
  }
}
