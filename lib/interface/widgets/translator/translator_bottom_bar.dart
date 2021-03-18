import 'package:flutter/material.dart';
import 'package:supernova_translator/models/translator_page.dart';

class TranslatorBottomBar extends StatelessWidget {
  TranslatorBottomBar({this.pages})
      : assert(pages != null && pages.length > 0,
            'Pages are needed for this widget');
  final List<TranslatorPage> pages;

  @override
  Widget build(BuildContext context) {
    return TabBar(
        tabs: pages
            .map<Tab>((e) => Tab(
                  icon: Icon(e.icon),
                  text: e.description,
                ))
            .toList());
  }
}
