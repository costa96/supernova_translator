import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernova_translator/logic/blocs/translation_bloc/translation_bloc.dart';
import 'package:supernova_translator/logic/blocs/translation_options_bloc/bloc.dart';

import 'language_selector.dart';

class InputTranslation extends StatefulWidget {
  @override
  _InputTranslationState createState() => _InputTranslationState();
}

class _InputTranslationState extends State<InputTranslation> {
  TranslationOptionsBloc _translationOptionsBloc;

  @override
  void initState() {
    _translationOptionsBloc =
        TranslationOptionsBloc(BlocProvider.of<TranslationBloc>(context));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.025),
          child: Column(
            children: [
              BlocProvider.value(
                value: _translationOptionsBloc,
                child: Row(
                  children: [
                    Expanded(child: LanguageSelector()),
                    IconButton(
                      icon: Icon(Icons.swap_horiz),
                      onPressed: () => _translationOptionsBloc.swapLanguages(),
                    ),
                    Expanded(
                        child: LanguageSelector(
                      isInitial: false,
                    ))
                  ],
                ),
              ),
              TextField(
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(hintText: "Translate me"),
                onChanged: (String text) {
                  _translationOptionsBloc.setStartingText(text);
                },
              ),
            ],
          )),
    );
  }
}
