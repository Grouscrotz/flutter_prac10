import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repository/topics_repository.dart';
import 'progress_state.dart';

class ProgressCubit extends Cubit<ProgressState> {
  final repo = TopicsRepository();
  ProgressCubit() : super(_calculate());

  static ProgressState _calculate() {
    final repo = TopicsRepository();
    final total = repo.topics.expand((t) => t.words).length;

    final learned = repo.topics.expand((t)
    => t.words.where((w) => w.learned)).length;

    final progress = total > 0 ? (learned.toDouble()
        / total.toDouble()) * 100 : 0.0;

    final topicProgress = repo.topics.map((t) {
      return t.words.isEmpty ? 0.0 : (t.words.where((w)
      => w.learned).length.toDouble() /
          t.words.length.toDouble()) * 100;
    }).toList();

    return ProgressState(progress, learned, total, topicProgress);
  }

  void refresh() => emit(_calculate());
}

