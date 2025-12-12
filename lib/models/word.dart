import 'package:equatable/equatable.dart';

class Word extends Equatable {
  final String word;
  final String translation;
  final String? url;
  final bool learned;

  const Word({
    required this.word,
    required this.translation,
    this.url,
    this.learned = false,
  });

  Word copyWith({bool? learned}) {
    return Word(
      word: this.word,
      translation: this.translation,
      url: this.url,
      learned: learned ?? this.learned,
    );
  }

  @override
  List<Object?> get props => [word, translation, url, learned];
}