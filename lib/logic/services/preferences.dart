import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:supernova_translator/models/dto/translation.dart';

class Preferences {
  final favoriteTranslationsKey = "favorite-translations-list";
  SharedPreferences prefs;

  Future<void> saveFavoriteTranslations(
      List<Translation> favTranslations) async {
    await checkInitialization();

    await prefs.setString(favoriteTranslationsKey,
        json.encode(favTranslations.map((e) => e.toJson()).toList()));
  }

  Future<List<Translation>> loadFavoriteTranslation() async {
    await checkInitialization();
    String saved = prefs.getString(favoriteTranslationsKey);
    return (json.decode(saved ?? [].toString()) as List)
        .map((e) => Translation.fromJson(e))
        .toList();
  }

  Future<void> checkInitialization() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
    }
  }
}
