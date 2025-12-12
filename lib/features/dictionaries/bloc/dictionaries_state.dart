import 'package:equatable/equatable.dart';
import '../../../models/topic.dart';

class DictionariesState extends Equatable {
  final List<Topic> topics;

  const DictionariesState(this.topics);

  @override
  List<Object?> get props => [topics];
}