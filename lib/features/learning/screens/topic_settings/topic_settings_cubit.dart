import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../repository/topics_repository.dart';
import 'topic_settings_state.dart';

class TopicSettingsCubit extends Cubit<TopicSettingsState> {
  final repo = TopicsRepository();

  TopicSettingsCubit() : super(_buildState());

  static TopicSettingsState _buildState() {
    final repo = TopicsRepository();
    final topic = repo.selectedTopic;
    return TopicSettingsState(topic, topic.words.length);
  }

  void refresh() => emit(_buildState());
}