import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../models/topic.dart';
import '../../../../models/word.dart';
import '../../../../repository/topics_repository.dart';
import 'flashcard_state.dart';

class FlashCardCubit extends Cubit<FlashCardState> {
  final TopicsRepository repo = TopicsRepository();
  final Topic topic;
  final bool learningNew;

  FlashCardCubit({required this.topic, required this.learningNew})
      : super(FlashCardState(words: _getWords(topic, learningNew))) {
    _shuffle();
  }
  void showTranslation() => emit(state.copyWith(showTranslation: true));

  static List<Word> _getWords(Topic topic, bool learningNew) {
    return topic.words.where((w) => w.learned == !learningNew).toList();
  }

  void _next() {
    if (state.words.isEmpty) return;
    final next = (state.currentIndex + 1) % state.words.length;
    emit(state.copyWith(currentIndex: next, showTranslation: false));
    if (next == 0) {
    }
  }

  void showAgain() {
    if (state.words.isEmpty) return;
    final word = state.words.removeAt(state.currentIndex);
    final newList = [...state.words, word];
    emit(state.copyWith(words: newList,
        currentIndex: state.currentIndex % newList.length,
        showTranslation: false));
  }

  void _shuffle() {
    final shuffled = [...state.words]..shuffle();
    emit(state.copyWith(words: shuffled));
  }


  void rememberWord() {
    if (state.words.isEmpty) return;
    final word = state.words[state.currentIndex];
    repo.toggleLearned(topic, word, true);
    _next();
  }



}