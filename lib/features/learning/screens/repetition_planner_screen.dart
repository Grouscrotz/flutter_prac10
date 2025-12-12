import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prac9/repository/topics_repository.dart';

class RepetitionPlannerScreen extends StatelessWidget {
  const RepetitionPlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final topic = TopicsRepository().selectedTopic;
    final wordsForReview = topic.words.where((w) => w.learned).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFcfd9df),
      appBar: AppBar(
        title: const Text('Планировщик повторений'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Информационная карточка
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.lightbulb, color: Colors.amber),
                        SizedBox(width: 8),
                        Text(
                          'Алгоритм интервальных повторений',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Система автоматически рассчитывает оптимальное время для повторения слов, основываясь на кривой забывания Эббингауза.',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        _buildStatChip('${wordsForReview.length}', 'слов для повторения'),
                        const SizedBox(width: 12),
                        _buildStatChip('7', 'дней расписание'),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Расписание
            const Text(
              'Ближайшие повторения:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            Expanded(
              child: wordsForReview.isEmpty
                  ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.calendar_month, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      'Нет слов для повторения',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Изучите новые слова, чтобы увидеть расписание',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              )
                  : ListView.builder(
                itemCount: wordsForReview.length,
                itemBuilder: (context, index) {
                  final word = wordsForReview[index];
                  final days = (index % 3) + 1; // Заглушка для демо

                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: _getColorForDay(days),
                        child: Text(
                          '$days',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(word.word),
                      subtitle: Text(word.translation),
                      trailing: Chip(
                        label: Text('${days} день'),
                        backgroundColor: _getColorForDay(days).withOpacity(0.1),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Кнопка запуска
            if (wordsForReview.isNotEmpty)
              Container(
                padding: const EdgeInsets.only(top: 16),
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => context.push(
                    '/flashcard',
                    extra: {'topic': topic, 'learningNew': false},
                  ),
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Начать повторение по расписанию'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatChip(String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.indigo.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Color _getColorForDay(int days) {
    switch (days) {
      case 1: return Colors.red;
      case 2: return Colors.orange;
      case 3: return Colors.yellow;
      case 7: return Colors.green;
      default: return Colors.blue;
    }
  }
}