import 'package:flutter/material.dart';
import 'package:supernova_translator/interface/widgets/translator/input_translation.dart';
import 'package:supernova_translator/interface/widgets/translator/translations_list.dart';

class TranslatePage extends StatefulWidget {
  @override
  _TranslatePageState createState() => _TranslatePageState();
}

class _TranslatePageState extends State<TranslatePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputTranslation(),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.width * 0.02),
          child: Text(
            'Translations',
            style: TextStyle(
                color: Theme.of(context).disabledColor,
                fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(child: TranslationsList())
      ],
    );
  }
}
