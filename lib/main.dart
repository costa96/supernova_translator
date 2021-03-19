import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'interface/screens/main_screen.dart';
import 'utils/translation_client.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(providers: [
        Provider(
          create: (_) => TranslationClient(),
          dispose: (_, TranslationClient translationClient) =>
              translationClient.dispose(),
        ),
      ], child: MainScreen()),
    );
  }
}
