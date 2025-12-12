import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prac9/features/learning/screens/topic_settings/topic_settings_cubit.dart';
import 'package:prac9/features/learning/screens/topic_settings/topic_settings_state.dart';


class TopicSettingsPage extends StatelessWidget {
  const TopicSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TopicSettingsCubit(),
      child: const TopicSettingsView(),
    );
  }
}


class TopicSettingsView extends StatelessWidget {
  const TopicSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки словаря'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      backgroundColor: const Color(0xFFcfd9df),
      body: BlocBuilder<TopicSettingsCubit, TopicSettingsState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Card(
                  child: ListTile(
                    title: const Text('Название'),
                    subtitle: Text(state.topic.name),
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  child: ListTile(
                    title: const Text('Всего слов'),
                    subtitle: Text('${state.wordCount}'),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => context.push('/word_preview'),
                  child: const Text('Предпросмотр слов'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}