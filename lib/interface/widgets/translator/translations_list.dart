import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernova_translator/interface/widgets/translator/translation_card.dart';
import 'package:supernova_translator/logic/blocs/translation_bloc/bloc.dart';
import 'package:supernova_translator/models/dto/translation.dart';

class TranslationsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TranslationBloc, List<Translation>>(
        bloc: BlocProvider.of<TranslationBloc>(context),
        builder: (context, List<Translation> _translationState) {
          if (_translationState == null) {
            return Container();
          }
          return ListView(
              shrinkWrap: true,
              children: List.generate(_translationState.length,
                  (index) => TranslationCard(_translationState[index])));
        });
  }
}
