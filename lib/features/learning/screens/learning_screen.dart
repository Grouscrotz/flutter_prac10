import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/learning_cubit.dart';
import '../bloc/learning_state.dart';
import '../widgets/button.dart';

class LearningPage extends StatelessWidget {
  const LearningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LearningCubit(),
      child: const LearningView(),
    );
  }
}

class LearningView extends StatelessWidget {
  const LearningView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFcfd9df),
      appBar: AppBar(
        title: const Text('Изучение'),
        actions: [
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
      body: BlocBuilder<LearningCubit, LearningState>(
        builder: (context, state) {
          return SingleChildScrollView( // ИЗМЕНЕНО: Добавлен скролл
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // Оставляем min
                      children: [
                        // Заголовок с иконкой
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.indigo.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.school,
                            size: 40,
                            color: Colors.indigo,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Словарь: ${state.topic.name}',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${state.topic.words.length} слов • ${state.newCount} новых • ${state.repeatCount} для повторения',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Основные режимы обучения
                        const Text(
                          'Основные режимы',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.indigo,
                          ),
                        ),
                        const SizedBox(height: 16),

                        MyButton(
                          icon: Icons.play_arrow,
                          iconColor: Colors.green,
                          label: 'Учить новые слова',
                          counter: state.newCount,
                          onPressed: () => context.push(
                            '/flashcard',
                            extra: {'topic': state.topic, 'learningNew': true},
                          ),
                        ),
                        const SizedBox(height: 12),

                        MyButton(
                          icon: Icons.refresh,
                          iconColor: Colors.orange,
                          label: 'Повторить слова',
                          counter: state.repeatCount,
                          onPressed: () => context.push(
                            '/flashcard',
                            extra: {'topic': state.topic, 'learningNew': false},
                          ),
                        ),
                        const SizedBox(height: 12),

                        MyButton(
                          icon: Icons.settings,
                          iconColor: Colors.blue,
                          label: 'Настройки словаря',
                          counter: 1,
                          onPressed: () => context.push('/topic_settings'),
                        ),

                        const SizedBox(height: 32),

                        // Дополнительные режимы
                        const Text(
                          'Продвинутые режимы',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.indigo,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // В 2 колонки для компактности
                        Row(
                          children: [
                            Expanded(
                              child: _buildFeatureCard(
                                context,
                                icon: Icons.calendar_month,
                                color: Colors.purple,
                                title: 'Планировщик\nповторений',
                                subtitle: 'Умное расписание',
                                onTap: () => context.push('/repetition_planner'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildFeatureCard(
                                context,
                                icon: Icons.photo_library,
                                color: Colors.teal,
                                title: 'Контекстные\nассоциации',
                                subtitle: 'Картинки + контекст',
                                onTap: () => context.push('/context_associations'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Предпросмотр
                        OutlinedButton.icon(
                          onPressed: () => context.push('/word_preview'),
                          icon: const Icon(Icons.list, size: 20),
                          label: const Text('Предпросмотр всех слов'),
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 48),
                            side: const BorderSide(color: Colors.indigo),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeatureCard(
      BuildContext context, {
        required IconData icon,
        required Color color,
        required String title,
        required String subtitle,
        required VoidCallback onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}