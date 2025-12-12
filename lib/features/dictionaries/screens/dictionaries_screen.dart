import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/dictionaries_cubit.dart';
import '../bloc/dictionaries_state.dart';
import '../widgets/topic_card.dart';

class DictionariesPage extends StatelessWidget {
  const DictionariesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DictionariesCubit(),
      child: const DictionariesView(),
    );
  }
}

class DictionariesView extends StatelessWidget {
  const DictionariesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFcfd9df),
      appBar: AppBar(
        title: const Text('Словари'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.go('/settings'),
            tooltip: 'Настройки',
          ),
          IconButton(
            icon: const Icon(Icons.book),
            onPressed: () => context.go('/dictionaries'),
            tooltip: 'Словари',
          ),
          IconButton(
            icon: const Icon(Icons.school),
            onPressed: () => context.go('/learning'),
            tooltip: 'Изучение',
          ),
          IconButton(
            icon: const Icon(Icons.analytics),
            onPressed: () => context.go('/progress'),
            tooltip: 'Прогресс',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: BlocBuilder<DictionariesCubit, DictionariesState>(
          builder: (context, state) {
            return ListView.builder(
              itemCount: state.topics.length,
              itemBuilder: (_, i) {
                final topic = state.topics[i];
                return TopicCard(
                  topic: topic,
                  selected: topic.selected,
                  onTap: () => context.read<DictionariesCubit>().selectTopic(i),
                  onResetProgress: () => context.read<DictionariesCubit>().resetProgress(i),
                  onShowWords: () => _showWords(context, i),
                  onAddWord: () => _showAddWord(context, i),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: _buildFAB(context),
    );
  }

  Widget _buildFAB(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _showAddOptions(context),
      child: const Icon(Icons.add),
    );
  }

  void _showAddOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Добавить словарь',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Опция 1: Новая тема
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.create, color: Colors.blue),
              ),
              title: const Text('Создать новую тему'),
              subtitle: const Text('Добавить пустой словарь'),
              onTap: () {
                Navigator.pop(context);
                _showAddTopicDialog(context);
              },
            ),

            // Опция 2: Импорт
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.download, color: Colors.green),
              ),
              title: const Text('Импорт словаря'),
              subtitle: const Text('Из файла, текста или шаблона'),
              onTap: () {
                Navigator.pop(context);
                context.go('/import_export');
              },
            ),

            // Опция 3: Быстрый старт
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.lightbulb, color: Colors.orange),
              ),
              title: const Text('Готовые шаблоны'),
              subtitle: const Text('Популярные темы для изучения'),
              onTap: () {
                Navigator.pop(context);
                _showTemplatesQuick(context);
              },
            ),

            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Отмена'),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddTopicDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Новая тема'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Название'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                context.read<DictionariesCubit>().addTopic(controller.text);
              }
              Navigator.pop(context);
            },
            child: const Text('Добавить'),
          ),
        ],
      ),
    );
  }

  void _showTemplatesQuick(BuildContext context) {
    final templates = [
      {'name': 'Английский для путешествий', 'words': 50},
      {'name': 'Бизнес-английский', 'words': 40},
      {'name': 'IT и технологии', 'words': 60},
      {'name': 'Еда и рестораны', 'words': 35},
      {'name': 'Спорт и фитнес', 'words': 30},
    ];

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Выберите шаблон'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: templates.length,
            itemBuilder: (_, index) {
              final template = templates[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.library_books, size: 20, color: Colors.blue),
                  ),
                  title: Text(template['name'] as String),
                  subtitle: Text('${template['words']} слов'),
                  trailing: const Icon(Icons.add, color: Colors.green),
                  onTap: () {
                    Navigator.pop(context);
                    context.read<DictionariesCubit>().addTopic(template['name'] as String);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Шаблон "${template['name']}" добавлен'),
                        backgroundColor: Colors.green,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
        ],
      ),
    );
  }

  void _showAddWord(BuildContext context, int topicIndex) {
    final wordCtrl = TextEditingController();
    final transCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Добавить слово'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: wordCtrl,
              decoration: const InputDecoration(labelText: 'Слово'),
            ),
            TextField(
              controller: transCtrl,
              decoration: const InputDecoration(labelText: 'Перевод'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () {
              if (wordCtrl.text.isNotEmpty && transCtrl.text.isNotEmpty) {
                context.read<DictionariesCubit>().addWord(
                  topicIndex,
                  wordCtrl.text,
                  transCtrl.text,
                );
              }
              Navigator.pop(context);
            },
            child: const Text('Добавить'),
          ),
        ],
      ),
    );
  }

  void _showWords(BuildContext context, int topicIndex) {
    final cubit = context.read<DictionariesCubit>();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(cubit.state.topics[topicIndex].name),
        content: SizedBox(
          width: 300,
          height: 300,
          child: ListView.builder(
            itemCount: cubit.state.topics[topicIndex].words.length,
            itemBuilder: (_, i) {
              final w = cubit.state.topics[topicIndex].words[i];
              return ListTile(
                title: Text(w.word),
                subtitle: Text(w.translation),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    cubit.deleteWord(topicIndex, i);
                    Navigator.pop(context);
                    _showWords(context, topicIndex);
                  },
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Закрыть'),
          )
        ],
      ),
    );
  }
}