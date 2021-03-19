import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:supernova_translator/logic/blocs/languages_bloc/languages_bloc.dart';
import 'package:supernova_translator/logic/blocs/translation_options_bloc/bloc.dart';
import 'package:supernova_translator/logic/services/google_translate_api_service.dart';
import 'package:supernova_translator/models/dto/language.dart';
import 'package:supernova_translator/utils/translation_client.dart';

class InputTranslation extends StatefulWidget {
  @override
  _InputTranslationState createState() => _InputTranslationState();
}

class _InputTranslationState extends State<InputTranslation> {
  LanguagesBloc _languagesBloc;
  TranslationOptionsBloc _translationOptionsBloc;

  @override
  void initState() {
    TranslationClient _translationClient =
        Provider.of<TranslationClient>(context, listen: false);

    _languagesBloc = LanguagesBloc(
        _translationClient.client.getService<GoogleTranslateApiService>());

    _translationOptionsBloc = TranslationOptionsBloc();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 400,
        child: BlocBuilder<LanguagesBloc, List<Language>>(
            bloc: _languagesBloc,
            builder: (context, List<Language> _languagesState) {
              if (_languagesState == null) {
                return CircularProgressIndicator();
              }
              return Column(
                children: [
                  initialLanguageDropdown(),
                  Expanded(
                    child: ListView(
                        children: _languagesState
                            .map<Widget>((e) => Text(e.name))
                            .toList()),
                  ),
                ],
              );
            }),
      ),
    );
  }

  Widget initialLanguageDropdown() {
    return BlocBuilder<TranslationOptionsBloc, TranslationOptions>(
        bloc: _translationOptionsBloc,
        builder: (context, TranslationOptions _optionsState) {
          return DropdownButton<Language>(
            value: _optionsState.initialLanguage,
            icon: const Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (Language newValue) {
              _translationOptionsBloc.setInitialLanguage(newValue);
            },
            items: _languagesBloc.state
                .map<DropdownMenuItem<Language>>((Language value) {
              return DropdownMenuItem<Language>(
                value: value,
                child: Text(value.name),
              );
            }).toList(),
          );
        });
  }
}
