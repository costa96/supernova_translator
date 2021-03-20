import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernova_translator/interface/widgets/translator/swap_button.dart';
import 'package:supernova_translator/logic/blocs/focus_textfield_bloc/bloc.dart';
import 'package:supernova_translator/logic/blocs/translation_bloc/loading/loading_translation_bloc.dart';
import 'package:supernova_translator/logic/blocs/translation_bloc/translation_bloc.dart';
import 'package:supernova_translator/logic/blocs/translation_options_bloc/bloc.dart';

import 'language_selector.dart';

class InputTranslation extends StatefulWidget {
  @override
  _InputTranslationState createState() => _InputTranslationState();
}

class _InputTranslationState extends State<InputTranslation> {
  TranslationOptionsBloc _translationOptionsBloc;
  FocusTextfieldBloc _focusTextfieldBloc;
  FocusNode focus;

  @override
  void initState() {
    _translationOptionsBloc =
        TranslationOptionsBloc(BlocProvider.of<TranslationBloc>(context));
    _focusTextfieldBloc = FocusTextfieldBloc();

    focus = FocusNode();
    focus.addListener(() {
      setState(() => _focusTextfieldBloc.toggle());
    });

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
                    BlocProvider.value(
                        value: _translationOptionsBloc, child: SwapButton()),
                    Expanded(
                        child: LanguageSelector(
                      isInitial: false,
                    ))
                  ],
                ),
              ),
              Stack(
                children: [
                  TextField(
                    focusNode: focus,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                        hintText: "Translate me",
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor))),
                    onChanged: (String text) {
                      _translationOptionsBloc.setStartingText(text);
                    },
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: BlocBuilder<FocusTextfieldBloc, bool>(
                        bloc: _focusTextfieldBloc,
                        builder: (context, bool isFocused) {
                          if (isFocused) {
                            return BlocBuilder<LoadingTranslationBloc, bool>(
                                bloc: BlocProvider.of<TranslationBloc>(context)
                                    .loadingBloc,
                                builder: (context, bool loading) {
                                  return Container(
                                    color: Colors.white,
                                    child: LinearProgressIndicator(
                                      value: loading ? null : 0,
                                      minHeight: 2,
                                      backgroundColor: loading
                                          ? null
                                          : Theme.of(context).primaryColor,
                                    ),
                                  );
                                });
                          }

                          return Container();
                        }),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
