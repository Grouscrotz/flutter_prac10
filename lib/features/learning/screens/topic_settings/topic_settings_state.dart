import 'package:equatable/equatable.dart';
import '../../../../models/topic.dart';


class TopicSettingsState extends Equatable {
  final Topic topic;
  final int wordCount;

  const TopicSettingsState(this.topic, this.wordCount);

  @override
  List<Object?> get props => [topic, wordCount];
}