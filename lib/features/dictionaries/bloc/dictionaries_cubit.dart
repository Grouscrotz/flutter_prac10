import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repository/topics_repository.dart';
import 'dictionaries_state.dart';

class DictionariesCubit extends Cubit<DictionariesState> {
  final repo = TopicsRepository();

  DictionariesCubit() : super(DictionariesState(TopicsRepository().topics));

  void refresh() => emit(DictionariesState(repo.topics));

  void addTopic(String name) {
    repo.addTopic(name);
    refresh();
  }

  void selectTopic(int index) {
    repo.selectTopic(repo.topics[index]);
    refresh();
  }

  void addWord(int topicIndex, String word, String translation) {
    repo.addWord(repo.topics[topicIndex], word, translation);
    refresh();
  }

  void deleteWord(int topicIndex, int wordIndex) {
    repo.deleteWord(repo.topics[topicIndex], wordIndex);
    refresh();
  }

  void resetProgress(int topicIndex) {
    repo.resetProgress(repo.topics[topicIndex]);
    refresh();
  }
}