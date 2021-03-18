import 'package:flutter/material.dart';
import 'package:supernova_translator/models/dto/translation.dart';

class TranslationCard extends StatelessWidget {
  TranslationCard(this.translation);
  Translation translation;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(translation.startingText),
                Container(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                Text(
                  translation.finalText,
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
              ],
            ),
            Icon(Icons.favorite)
          ],
        ),
      ),
    );
  }
}
