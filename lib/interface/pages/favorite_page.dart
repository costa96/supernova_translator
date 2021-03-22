import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernova_translator/interface/widgets/translator/translation_card.dart';
import 'package:supernova_translator/logic/blocs/preferences_bloc/bloc.dart';
import 'package:supernova_translator/models/dto/translation.dart';

class FavoritePage extends StatefulWidget {
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
            children: translationsSaved.map((e) => TranslationCard(e)).toList(),
          );
        });
  }
}
