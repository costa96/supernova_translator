// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:chopper/chopper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supernova_translator/logic/services/google_translate_api_service.dart';
import 'package:supernova_translator/models/dto/language.dart';
import 'package:supernova_translator/utils/translation_client.dart';

void main() {
  TranslationClient _translationClient = TranslationClient();
  GoogleTranslateApiService _service =
      _translationClient.client.getService<GoogleTranslateApiService>();

  test('Testing languages endpoint', () async {
    Response resp = await _service.getLanguages();
    print(resp.body);
    expect(resp.isSuccessful, true);
  });

  test('Testing translation endpoint', () async {
    Response resp = await _service.translateText(
        "ciao!", Language(iso: "en", name: "English"));

    print(resp.body);
    expect(resp.isSuccessful, true);
  });

  test('Testing detection endpoint', () async {
    TranslationClient _translationClient = TranslationClient();
    GoogleTranslateApiService _service =
        _translationClient.client.getService<GoogleTranslateApiService>();
    Response resp = await _service.getLanguages();

    print(resp.body);
    expect(resp.isSuccessful, true);
  });
}
