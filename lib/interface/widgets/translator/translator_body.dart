import 'package:flutter/material.dart';
import 'package:supernova_translator/models/translator_page.dart';

class TranslatorBody extends StatelessWidget {
  TranslatorBody({this.pages})
      : assert(pages != null && pages.length > 0,
            'Pages are needed for this widget');
  final List<TranslatorPage> pages;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: pages.map<Widget>((e) => e.page).toList(),
    );
  }
}
