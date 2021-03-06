import 'package:flutter/material.dart';
import 'package:supernova_translator/models/translator_page.dart';

class TranslatorBottomBar extends StatelessWidget {
  TranslatorBottomBar({this.pages, this.controller})
      : assert(pages != null && pages.length > 0,
            'Pages are needed for this widget');
  final List<TranslatorPage> pages;

  final TabController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: TabBar(
          controller: controller,
          indicator: BoxDecoration(),
          unselectedLabelColor: Theme.of(context).unselectedWidgetColor,
          labelColor: Theme.of(context).primaryColor,
          tabs: pages
              .map<Tab>((e) => Tab(
                    icon: Icon(e.icon),
                    text: e.description,
                  ))
              .toList()),
    );
  }
}
