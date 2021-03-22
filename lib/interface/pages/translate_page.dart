import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:supernova_translator/interface/widgets/translator/input_translation.dart';
import 'package:supernova_translator/interface/widgets/translator/translations_list.dart';
import 'package:supernova_translator/logic/blocs/languages_bloc/languages_bloc.dart';
import 'package:supernova_translator/logic/blocs/translation_bloc/translation_bloc.dart';
import 'package:supernova_translator/utils/translation_client.dart';

import 'file:///D:/GIT/supernova_translator/lib/logic/services/api_comunication/google_translate_api_service.dart';

class TranslatePage extends StatefulWidget {
  @override
  _TranslatePageState createState() => _TranslatePageState();
}

class _TranslatePageState extends State<TranslatePage>
    with AutomaticKeepAliveClientMixin {
  GoogleTranslateApiService _translateApiService;
  LanguagesBloc _languagesBloc;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _translateApiService =
        Provider.of<TranslationClient>(context, listen: false)
            .client
            .getService<GoogleTranslateApiService>();

    _languagesBloc = LanguagesBloc(_translateApiService);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) =>
              TranslationBloc(_translateApiService, _languagesBloc),
        ),
        BlocProvider.value(value: _languagesBloc)
      ],
      child: Column(
        children: [
          InputTranslation(),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.width * 0.02),
            child: Text(
              'Translations',
              style: TextStyle(
                  color: Theme.of(context).disabledColor,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(child: TranslationsList())
        ],
      ),
    );
  }
}
