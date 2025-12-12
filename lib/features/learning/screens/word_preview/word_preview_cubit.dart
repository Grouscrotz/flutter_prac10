// features/learning/word_preview/bloc/word_preview_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../repository/topics_repository.dart';

import 'word_preview_state.dart';

class WordPreviewCubit extends Cubit<WordPreviewState> {
  final repo = TopicsRepository();

  WordPreviewCubit() : super(WordPreviewState([])) {
    refresh(); // ← инициализируем после создания
  }

  void refresh() {
    emit(WordPreviewState(repo.selectedTopic.words));
  }
}