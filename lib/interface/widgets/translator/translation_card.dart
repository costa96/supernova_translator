import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernova_translator/logic/blocs/preferences_bloc/preferences_bloc.dart';
import 'package:supernova_translator/logic/blocs/single_preference_bloc/bloc.dart';
import 'package:supernova_translator/models/dto/translation.dart';

class TranslationCard extends StatefulWidget {
  TranslationCard(this.translation);
  Translation translation;

  @override
  _TranslationCardState createState() => _TranslationCardState();
}

class _TranslationCardState extends State<TranslationCard> {
  SinglePreferenceBloc _singlePreferenceBloc;

  @override
  void initState() {
    _singlePreferenceBloc = SinglePreferenceBloc(
        BlocProvider.of<PreferencesBloc>(context), widget.translation);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SinglePreferenceBloc, bool>(
        bloc: _singlePreferenceBloc,
        builder: (context, bool isSaved) {
          return Card(
            child: Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(widget.translation.startingText),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Text(
                          widget.translation.finalText,
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                        if (widget.translation.isDetected)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.015,
                              ),
                              Text(
                                'Detected language: ${widget.translation.startingLanguage.name} (${widget.translation.startingLanguage.iso})',
                                style: TextStyle(
                                    color: Theme.of(context).dividerColor,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          )
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () =>
                          _singlePreferenceBloc.toggle(widget.translation),
                      icon: Icon(
                          isSaved ? Icons.favorite : Icons.favorite_border))
                ],
              ),
            ),
          );
        });
  }
}
