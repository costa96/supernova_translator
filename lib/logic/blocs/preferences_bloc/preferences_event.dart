import 'package:supernova_translator/models/dto/translation.dart';

abstract class PreferencesEvent {}

class AddPreference extends PreferencesEvent {
  AddPreference(this.translation);
  Translation translation;
}

class RemovePreference extends PreferencesEvent {
  RemovePreference(this.translation);
  Translation translation;
}

class LoadPreferences extends PreferencesEvent {}
