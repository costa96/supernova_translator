import 'package:flutter_bloc/flutter_bloc.dart';

import 'loading_translation_event.dart';

class LoadingTranslationBloc extends Bloc<LoadingTranslationEvent, bool> {
  LoadingTranslationBloc() : super(false);

  void setLoading({bool loading = true}) => add(UpdateLoading(loading));

  @override
  Stream<bool> mapEventToState(LoadingTranslationEvent event) async* {
    if (event is UpdateLoading) {
      if (state != event.loading) {
        yield (event.loading);
      }
    }
  }
}
