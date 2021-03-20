import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernova_translator/interface/widgets/translator/translation_card.dart';
import 'package:supernova_translator/logic/blocs/translation_bloc/bloc.dart';
import 'package:supernova_translator/logic/blocs/translation_bloc/loading/loading_translation_bloc.dart';
import 'package:supernova_translator/models/dto/translation.dart';

class TranslationsList extends StatelessWidget {
  TranslationBloc _translationBloc;

  @override
  Widget build(BuildContext context) {
    _translationBloc = BlocProvider.of<TranslationBloc>(context);
    return BlocBuilder<TranslationBloc, List<Translation>>(
        bloc: _translationBloc,
        builder: (context, List<Translation> _translationState) {
          return Column(
            children: [
              BlocBuilder<LoadingTranslationBloc, bool>(
                  bloc: _translationBloc.loadingBloc,
                  builder: (context, bool loading) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.02),
                      child: LinearProgressIndicator(
                        value: loading ? null : 0,
                        backgroundColor: loading ? null : Colors.transparent,
                      ),
                    );
                  }),
              ListView(
                  shrinkWrap: true,
                  children: List.generate(_translationState.length,
                      (index) => TranslationCard(_translationState[index]))),
            ],
          );
        });
  }
}
