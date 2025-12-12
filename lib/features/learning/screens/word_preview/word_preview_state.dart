import 'package:equatable/equatable.dart';

import '../../../../models/word.dart';


class WordPreviewState extends Equatable {
  final List<Word> words;

  const WordPreviewState(this.words);

  @override
  List<Object?> get props => [words];
}