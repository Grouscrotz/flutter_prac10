import 'package:equatable/equatable.dart';
import '../../../models/topic.dart';

class LearningState extends Equatable {
  final Topic topic;
  final int newCount;
  final int repeatCount;

  const LearningState(this.topic, this.newCount, this.repeatCount);

  @override
  List<Object?> get props => [topic, newCount, repeatCount];
}