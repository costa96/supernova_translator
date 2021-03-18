import 'package:flutter/material.dart';
import 'package:supernova_translator/interface/widgets/translator/input_translation.dart';
import 'package:supernova_translator/interface/widgets/translator/translation_options.dart';

class TranslatePage extends StatelessWidget {
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
        Expanded(child: TranslationOptions())
      ],
    );
  }
}
