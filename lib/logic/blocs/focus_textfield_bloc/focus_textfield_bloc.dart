import 'package:flutter_bloc/flutter_bloc.dart';

import 'focus_textfield_event.dart';

class FocusTextfieldBloc extends Bloc<FocusTextfieldEvent, bool> {
  FocusTextfieldBloc() : super(false);

  void toggle() => add(ToggleFocus());

  @override
  Stream<bool> mapEventToState(FocusTextfieldEvent event) async* {
    if (event is ToggleFocus) {
      yield (!state);
    }
  }
}
