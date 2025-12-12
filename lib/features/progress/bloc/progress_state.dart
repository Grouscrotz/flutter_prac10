import 'package:equatable/equatable.dart';
import '../../../models/topic.dart';

class ProgressState extends Equatable {
  final double totalProgress;
  final int learned;
  final int total;
  final List<double> topicProgress;

  const ProgressState(this.totalProgress, this.learned, this.total, this.topicProgress);

  @override
  List<Object?> get props => [totalProgress, learned, total, topicProgress];
}