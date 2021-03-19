import 'package:flutter/material.dart';
import 'package:supernova_translator/interface/widgets/translator/translation_card.dart';
import 'package:supernova_translator/models/dto/language.dart';
import 'package:supernova_translator/models/dto/translation.dart';

class TranslationsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
        shrinkWrap: true,
        children: List.generate(
            6,
            (index) => TranslationCard(Translation(
                startingText: "Ciao",
                startingLanguage: Language(name: "Italian", iso: "it"),
                finalLanguage: Language(name: "Romanian", iso: "ro"),
                finalText: "Hola"))));
  }
}
