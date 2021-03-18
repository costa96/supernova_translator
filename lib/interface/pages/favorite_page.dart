import 'package:flutter/material.dart';
import 'package:supernova_translator/interface/widgets/translator/translation_card.dart';
import 'package:supernova_translator/models/dto/language.dart';
import 'package:supernova_translator/models/dto/translation.dart';

class FavoritePage extends StatelessWidget {
  Language english = Language(name: "English", iso: "en");

  Language italian = Language(name: "Italian", iso: "it");

  Language romanian = Language(name: "Romanian", iso: "ro");

  Language spanish = Language(name: "Spanish", iso: "es");

  @override
  Widget build(BuildContext context) {
    List<Translation> translations = [
      Translation(
          startingText: "Ciao",
          startingLanguage: italian,
          finalLanguage: spanish,
          finalText: "Hola"),
      Translation(
          startingText: "Ciao",
          startingLanguage: italian,
          finalLanguage: english,
          finalText: "Hi"),
      Translation(
          startingText: "Ciau",
          startingLanguage: romanian,
          finalLanguage: italian,
          finalText: "Ciao"),
    ];

    return ListView(
      shrinkWrap: true,
      children: translations.map((e) => TranslationCard(e)).toList(),
    );
  }
}
