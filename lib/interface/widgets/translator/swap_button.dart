import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernova_translator/logic/blocs/languages_bloc/languages_bloc.dart';
import 'package:supernova_translator/logic/blocs/translation_options_bloc/translation_options_bloc.dart';

class SwapButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: BlocProvider.of<LanguagesBloc>(context),
        builder: (context, List languages) {
          return AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: languages == null
                ? IconButton(
                    /// Bad implementation, but matches the size of the icon button below
                    icon: Center(
                        child: Container(
                            height: MediaQuery.of(context).size.width * 0.04,
                            width: MediaQuery.of(context).size.width * 0.04,
                            child: CircularProgressIndicator(strokeWidth: 3))),
                  )
                : IconButton(
                    icon: Icon(Icons.swap_horiz),
                    onPressed: () =>
                        BlocProvider.of<TranslationOptionsBloc>(context)
                            .swapLanguages(),
                  ),
          );
        });
  }
}
