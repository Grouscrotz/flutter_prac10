import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../models/topic.dart';
import '../../widgets/emptyState.dart';
import '../../widgets/word_card.dart';
import 'flashcard_cubit.dart';
import 'flashcard_state.dart';

class FlashCardPage extends StatelessWidget {
  final Topic topic;
  final bool learningNew;

  const FlashCardPage({
    super.key,
    required this.topic,
    required this.learningNew,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FlashCardCubit(topic: topic, learningNew: learningNew),
      child: const FlashCardView(),
    );
  }
}


class FlashCardView extends StatelessWidget {
  const FlashCardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Карточки: ${context.read<FlashCardCubit>().topic.name}'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      backgroundColor: const Color(0xFFcfd9df),
      body: BlocBuilder<FlashCardCubit, FlashCardState>(
        builder: (context, state) {
          if (state.words.isEmpty) {
            return const EmptyStateScreen();
          }
          final word = state.words[state.currentIndex];
          return Center(
            child: WordCard(
              word: word,
              showTranslation: state.showTranslation,
              onShowTranslation: () => context.read<FlashCardCubit>().showTranslation(),
              onShowAgain: () => context.read<FlashCardCubit>().showAgain(),
              onRemembered: () => context.read<FlashCardCubit>().rememberWord(),
            ),
          );
        },
      ),
    );
  }
}