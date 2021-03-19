abstract class LanguagesEvent {}

class GetLanguages extends LanguagesEvent {
  GetLanguages({this.target});

  final String target;
}
