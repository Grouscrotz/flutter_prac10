import 'package:equatable/equatable.dart';
import 'word.dart';

class Topic extends Equatable {
  final String name;
  final List<Word> words;
  final bool selected;

  const Topic({
    required this.name,
    required this.words,
    this.selected = false,
  });

  Topic copyWith({
    String? name,
    List<Word>? words,
    bool? selected,
  }) {
    return Topic(
      name: name ?? this.name,
      words: words ?? this.words,
      selected: selected ?? this.selected,
    );
  }

  @override
  List<Object?> get props => [name, words, selected];
}