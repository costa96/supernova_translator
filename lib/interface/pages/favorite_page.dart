import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernova_translator/interface/widgets/translator/translation_card.dart';
import 'package:supernova_translator/logic/blocs/preferences_bloc/bloc.dart';
import 'package:supernova_translator/logic/blocs/translation_options_bloc/translation_options.dart';
import 'package:supernova_translator/logic/blocs/translation_options_bloc/translation_options_bloc.dart';
import 'package:supernova_translator/models/dto/language.dart';
import 'package:supernova_translator/models/dto/translation.dart';

class FavoritePage extends StatefulWidget {
  FavoritePage(this.tabController);
  TabController tabController;
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage>
    with AutomaticKeepAliveClientMixin {
  PreferencesBloc _preferencesBloc;

  @override
  void initState() {
    _preferencesBloc = BlocProvider.of<PreferencesBloc>(context);
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreferencesBloc, List<Translation>>(
        bloc: _preferencesBloc,
        builder: (context, List<Translation> translationsSaved) {
          return ListView(
            shrinkWrap: true,
            children: translationsSaved
                .map((e) => TranslationCard(
                      e,
                      onTap: () {
                        BlocProvider.of<TranslationOptionsBloc>(context)
                            .setOptions(TranslationOptions(
                          initialText: e.startingText,
                          initialLanguage: e.isDetected
                              ? Language.detect()
                              : e.startingLanguage,
                          finalLanguage: e.finalLanguage,
                        ));
                        widget.tabController.animateTo(0,
                            duration: Duration(milliseconds: 300));
                      },
                    ))
                .toList(),
          );
        });
  }
}
