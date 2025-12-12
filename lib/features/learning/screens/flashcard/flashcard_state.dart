import 'package:equatable/equatable.dart';
import '../../../../models/word.dart';

class FlashCardState extends Equatable {
  final List<Word> words;
  final int currentIndex;
  final bool showTranslation;

  const FlashCardState({
    required this.words,
    this.currentIndex = 0,
    this.showTranslation = false,
  });

  FlashCardState copyWith({
    List<Word>? words,
    int? currentIndex,
    bool? showTranslation,
  }) {
    return FlashCardState(
      words: words ?? this.words,
      currentIndex: currentIndex ?? this.currentIndex,
      showTranslation: showTranslation ?? this.showTranslation,
    );
  }

  @override
  List<Object?> get props => [words, currentIndex, showTranslation];
}