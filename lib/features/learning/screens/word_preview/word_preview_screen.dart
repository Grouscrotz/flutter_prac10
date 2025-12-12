import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prac9/features/learning/screens/word_preview/word_preview_cubit.dart';
import 'package:prac9/features/learning/screens/word_preview/word_preview_state.dart';
import '../../../../repository/topics_repository.dart';


class WordPreviewPage extends StatelessWidget {
  const WordPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WordPreviewCubit(),
      child: const WordPreviewView(),
    );
  }
}


class WordPreviewView extends StatelessWidget {
  const WordPreviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Предпросмотр слов'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      backgroundColor: const Color(0xFFcfd9df),
      body: BlocBuilder<WordPreviewCubit, WordPreviewState>(
        builder: (context, state) {
          if (state.words.isEmpty) {
            return const Center(child: Text('Нет слов'));
          }

          final topic = TopicsRepository().selectedTopic;

          return ListView.builder(
            padding: const EdgeInsets.only(top: 16),
            itemCount: state.words.length,
            itemBuilder: (context, index) {
              final word = state.words[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: ListTile(
                  title: Text(word.word),
                  subtitle: Text(word.translation),
                  trailing: word.learned
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : const Icon(Icons.radio_button_unchecked),
                  onTap: () => context.push(
                    '/flashcard',
                    extra: {
                      'topic': topic,
                      'learningNew': !word.learned,
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}