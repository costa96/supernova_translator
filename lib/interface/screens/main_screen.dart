import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:supernova_translator/interface/pages/favorite_page.dart';
import 'package:supernova_translator/interface/pages/translate_page.dart';
import 'package:supernova_translator/interface/widgets/translator/translator_bottom_bar.dart';
import 'package:supernova_translator/logic/blocs/languages_bloc/languages_bloc.dart';
import 'package:supernova_translator/logic/blocs/preferences_bloc/preferences_bloc.dart';
import 'package:supernova_translator/logic/blocs/translation_bloc/translation_bloc.dart';
import 'package:supernova_translator/logic/blocs/translation_options_bloc/translation_options_bloc.dart';
import 'package:supernova_translator/logic/services/api_comunication/google_translate_api_service.dart';
import 'package:supernova_translator/models/translator_page.dart';
import 'package:supernova_translator/utils/translation_client.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  List<TranslatorPage> pages;
  GoogleTranslateApiService _translateApiService;

  LanguagesBloc _languagesBloc;
  TranslationBloc _translationBloc;
  TranslationOptionsBloc _translationOptionsBloc;

  TabController _tabController;

  @override
  void initState() {
    _translateApiService =
        Provider.of<TranslationClient>(context, listen: false)
            .client
            .getService<GoogleTranslateApiService>();

    _languagesBloc = LanguagesBloc(_translateApiService);

    _translationBloc = TranslationBloc(_translateApiService, _languagesBloc);

    _translationOptionsBloc = TranslationOptionsBloc(_translationBloc);

    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);

    pages = [
      TranslatorPage(
          description: "Translate",
          icon: Icons.translate,
          page: TranslatePage()),
      TranslatorPage(
          description: "Favorite",
          icon: Icons.favorite,
          page: FavoritePage(_tabController)),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            lazy: false,
            create: (BuildContext context) => PreferencesBloc(),
          ),
          BlocProvider.value(
            value: _translationBloc,
          ),
          BlocProvider.value(value: _languagesBloc),
          BlocProvider.value(value: _translationOptionsBloc)
        ],
        child: TabBarView(
          controller: _tabController,
          children: pages.map<Widget>((e) => e.page).toList(),
        ),
      ),
      bottomNavigationBar:
          TranslatorBottomBar(pages: pages, controller: _tabController),
    );
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
