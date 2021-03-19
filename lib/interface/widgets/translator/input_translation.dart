import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernova_translator/logic/blocs/languages_bloc/languages_bloc.dart';
import 'package:supernova_translator/logic/blocs/translation_bloc/translation_bloc.dart';
import 'package:supernova_translator/logic/blocs/translation_options_bloc/bloc.dart';
import 'package:supernova_translator/models/dto/language.dart';

class InputTranslation extends StatefulWidget {
  @override
  _InputTranslationState createState() => _InputTranslationState();
}

class _InputTranslationState extends State<InputTranslation> {
  LanguagesBloc _languagesBloc;
  TranslationOptionsBloc _translationOptionsBloc;

  @override
  void initState() {
    _languagesBloc = BlocProvider.of<LanguagesBloc>(context);

    _translationOptionsBloc =
        TranslationOptionsBloc(BlocProvider.of<TranslationBloc>(context));

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
                  Row(
                    children: [
                      initialLanguageDropdown(),
                      IconButton(
                        icon: Icon(Icons.compare_arrows),
                        onPressed: () =>
                            _translationOptionsBloc.swapLanguages(),
                      ),
                      finalLanguageDropdown()
                    ],
                  ),
                  TextField(
                    onChanged: (String text) {
                      _translationOptionsBloc.setStartingText(text);
                    },
                  ),
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

  Widget finalLanguageDropdown() {
    return BlocBuilder<TranslationOptionsBloc, TranslationOptions>(
        bloc: _translationOptionsBloc,
        builder: (context, TranslationOptions _optionsState) {
          return DropdownButton<Language>(
            value: _optionsState.finalLanguage,
            icon: const Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (Language newValue) {
              _translationOptionsBloc.setFinalLanguage(newValue);
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
