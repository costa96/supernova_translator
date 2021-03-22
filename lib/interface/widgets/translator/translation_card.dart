import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernova_translator/logic/blocs/preferences_bloc/preferences_bloc.dart';
import 'package:supernova_translator/models/dto/translation.dart';

class TranslationCard extends StatefulWidget {
  TranslationCard(this.translation, {this.onTap});
  VoidCallback onTap;
  Translation translation;

  @override
  _TranslationCardState createState() => _TranslationCardState();
}

class _TranslationCardState extends State<TranslationCard> {
  PreferencesBloc _preferencesBloc;

  bool isSaved;

  @override
  void initState() {
    _preferencesBloc = BlocProvider.of<PreferencesBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreferencesBloc, List<Translation>>(
        bloc: _preferencesBloc,
        builder: (context, List<Translation> translations) {
          isSaved = translations.contains(widget.translation);
          return InkWell(
            onTap: widget.onTap,
            child: Card(
              child: Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
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
                                  height: MediaQuery.of(context).size.height *
                                      0.015,
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
                        onPressed: () => toggle(),
                        icon: Icon(
                            isSaved ? Icons.favorite : Icons.favorite_border))
                  ],
                ),
              ),
            ),
          );
        });
  }

  void toggle() {
    if (isSaved) {
      _preferencesBloc.removePreference(widget.translation);
    } else {
      _preferencesBloc.addPreference(widget.translation);
    }
  }
}
