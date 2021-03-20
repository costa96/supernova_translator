import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernova_translator/logic/blocs/languages_bloc/languages_bloc.dart';
import 'package:supernova_translator/logic/blocs/translation_options_bloc/bloc.dart';
import 'package:supernova_translator/models/dto/language.dart';

class LanguageSelector extends StatefulWidget {
  LanguageSelector({bool isInitial = true})
      : this.type = isInitial
            ? LanguageSelectorType.initialLanguage
            : LanguageSelectorType.finalLanguage;
  final LanguageSelectorType type;

  @override
  _LanguageSelectorState createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  TranslationOptionsBloc _translationOptionsBloc;
  LanguagesBloc _languagesBloc;

  @override
  void initState() {
    _languagesBloc = BlocProvider.of<LanguagesBloc>(context);

    _translationOptionsBloc = BlocProvider.of<TranslationOptionsBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguagesBloc, List<Language>>(
        bloc: _languagesBloc,
        builder: (context, List<Language> languagesState) {
          return BlocBuilder<TranslationOptionsBloc, TranslationOptions>(
              bloc: _translationOptionsBloc,
              builder: (context, TranslationOptions _optionsState) {
                List<Language> languages = [];
                if (languagesState != null) {
                  if (widget.type == LanguageSelectorType.initialLanguage) {
                    languages.add(Language.detect());
                  }
                  languages.addAll(languagesState);
                }
                if (widget.type == LanguageSelectorType.initialLanguage) {
                  if (_optionsState.finalLanguage != null) {
                    languages.remove(_optionsState.finalLanguage);
                  }
                } else {
                  if (_optionsState.initialLanguage != Language.detect()) {
                    languages.remove(_optionsState.initialLanguage);
                  }
                }

                return DropdownButton<Language>(
                  value: widget.type == LanguageSelectorType.initialLanguage
                      ? _optionsState.initialLanguage
                      : _optionsState.finalLanguage,
                  icon: Icon(Icons.arrow_drop_down),
                  isExpanded: true,
                  underline: Container(
                    height: 1,
                    color: Theme.of(context).dividerColor,
                  ),
                  onChanged: (Language newValue) {
                    if (widget.type == LanguageSelectorType.initialLanguage) {
                      _translationOptionsBloc.setInitialLanguage(newValue);
                    } else {
                      _translationOptionsBloc.setFinalLanguage(newValue);
                    }
                  },
                  items: (languages)
                      .map<DropdownMenuItem<Language>>((Language value) {
                    return DropdownMenuItem<Language>(
                      value: value,
                      child: Text(value.name),
                    );
                  }).toList(),
                );
              });
        });
  }
}

enum LanguageSelectorType { initialLanguage, finalLanguage }
