abstract class LoadingTranslationEvent {}

class UpdateLoading extends LoadingTranslationEvent {
  UpdateLoading(this.loading);
  final bool loading;
}
