import 'package:supernova_translator/models/dto/translation.dart';

abstract class SinglePreferenceEvent {}

class Toggle extends SinglePreferenceEvent {
  Toggle(this.translation);
  final Translation translation;
}
