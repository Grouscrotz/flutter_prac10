import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repository/topics_repository.dart';
import 'learning_state.dart';

class LearningCubit extends Cubit<LearningState> {
  final repo = TopicsRepository();

  LearningCubit() : super(_buildState());

  static LearningState _buildState() {
    final repo = TopicsRepository();
    final topic = repo.selectedTopic;
    final newCount = topic.words.where((w) => !w.learned).length;
    final repeatCount = topic.words.where((w) => w.learned).length;
    return LearningState(topic, newCount, repeatCount);
  }

  void refresh() => emit(_buildState());
}

