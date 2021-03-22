import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernova_translator/interface/pages/favorite_page.dart';
import 'package:supernova_translator/interface/pages/translate_page.dart';
import 'package:supernova_translator/interface/widgets/translator/translator_bottom_bar.dart';
import 'package:supernova_translator/logic/blocs/preferences_bloc/preferences_bloc.dart';
import 'package:supernova_translator/models/translator_page.dart';

class MainScreen extends StatelessWidget {
  List<TranslatorPage> pages = [
    TranslatorPage(
        description: "Translate", icon: Icons.translate, page: TranslatePage()),
    TranslatorPage(
        description: "Favorite", icon: Icons.favorite, page: FavoritePage()),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: pages.length,
        child: Scaffold(
          appBar: _appBar(context),
          body: BlocProvider(
            lazy: false,
            create: (BuildContext context) => PreferencesBloc(),
            child: TabBarView(
              children: pages.map<Widget>((e) => e.page).toList(),
            ),
          ),
          bottomNavigationBar: TranslatorBottomBar(pages: pages),
        ));
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      leading: MediaQuery.of(context).viewInsets.bottom > 0
          ? IconButton(
              icon: Icon(Icons.arrow_back_ios_rounded),
              onPressed: () => FocusScope.of(context).unfocus(),
            )
          : null,
      title: Center(
        child: Text('Supernova Translator'),
      ),
    );
  }
}
