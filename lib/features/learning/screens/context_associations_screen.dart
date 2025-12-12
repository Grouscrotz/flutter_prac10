import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prac9/repository/topics_repository.dart';
import '../../../models/word.dart';

class ContextAssociationsScreen extends StatelessWidget {
  const ContextAssociationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final topic = TopicsRepository().selectedTopic;
    final words = topic.words;

    // Примеры контекста для разных категорий слов
    final contextExamples = {
      'Фрукты': {
        'Apple': 'I eat an apple every morning for breakfast.',
        'Banana': 'Bananas are great for making smoothies.',
        'Orange': 'Orange juice is rich in vitamin C.',
        'Grape': 'We made wine from our own grapes.',
        'Strawberry': 'Strawberries are perfect for summer desserts.',
      },
      'Животные': {
        'Dog': 'My dog loves to play fetch in the park.',
        'Cat': 'The cat is sleeping on the windowsill.',
        'Elephant': 'Elephants have an excellent memory.',
        'Tiger': 'Tigers are endangered species in many countries.',
      },
      'Цвета': {
        'Red': 'The red rose symbolizes love and passion.',
        'Blue': 'The sky is clear blue today.',
        'Green': 'Green vegetables are good for your health.',
        'Yellow': 'Yellow flowers brighten up the room.',
      },
      'Транспорт': {
        'Car': 'We drove the car to the mountains.',
        'Bus': 'I take the bus to work every day.',
        'Train': 'The train arrives at platform 3.',
        'Bicycle': 'I ride my bicycle to stay fit.',
      }
    };

    // Ассоциации для слов
    final wordAssociations = {
      'Apple': ['fruit', 'red', 'healthy', 'tree'],
      'Banana': ['fruit', 'yellow', 'energy', 'monkey'],
      'Dog': ['pet', 'loyal', 'bark', 'friend'],
      'Cat': ['pet', 'independent', 'meow', 'sleep'],
      'Red': ['color', 'fire', 'love', 'danger'],
      'Blue': ['color', 'sky', 'sea', 'calm'],
      'Car': ['vehicle', 'drive', 'road', 'fast'],
      'Train': ['transport', 'rails', 'station', 'travel'],
    };

    return Scaffold(
      backgroundColor: const Color(0xFFcfd9df),
      appBar: AppBar(
        title: const Text('Контекстные ассоциации'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: words.isEmpty
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.photo_library, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Нет слов для ассоциаций',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Добавьте слова в словарь',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      )
          : Column(
        children: [
          // Информационная панель
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.indigo.withOpacity(0.05),
            child: Row(
              children: [
                const Icon(Icons.lightbulb, color: Colors.amber, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Контекстное запоминание',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'Слова запоминаются лучше, когда есть ассоциации и примеры использования',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade600,
                        ),
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
                Chip(
                  label: Text('${words.length} слов'),
                  backgroundColor: Colors.indigo.withOpacity(0.1),
                ),
              ],
            ),
          ),

          // Список слов с контекстом
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: words.length,
              itemBuilder: (context, index) {
                final word = words[index];
                final example = _getExample(word, contextExamples);
                final associations = _getAssociations(word, wordAssociations);

                return _buildWordCard(
                  context,
                  word,
                  example,
                  associations,
                  index % 4, // Для разных цветов карточек
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _getExample(Word word, Map<String, Map<String, String>> examples) {
    // Пытаемся найти пример для текущей темы и слова
    for (final category in examples.keys) {
      if (examples[category]!.containsKey(word.word)) {
        return examples[category]![word.word]!;
      }
    }

    // Пример по умолчанию, если не нашли
    return 'This is an example sentence with "${word.word}".';
  }

  List<String> _getAssociations(Word word, Map<String, List<String>> associations) {
    return associations[word.word] ?? ['vocabulary', 'learning', 'language'];
  }

  Widget _buildWordCard(
      BuildContext context,
      Word word,
      String example,
      List<String> associations,
      int colorIndex,
      ) {
    final colors = [
      Colors.blue.shade50,
      Colors.green.shade50,
      Colors.orange.shade50,
      Colors.purple.shade50,
    ];

    final iconColors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
    ];

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: colors[colorIndex],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Слово и перевод
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: iconColors[colorIndex].withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _getWordIcon(word.word),
                      size: 16,
                      color: iconColors[colorIndex],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          word.word,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          word.translation,
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (word.learned)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.check, size: 12, color: Colors.green),
                          SizedBox(width: 4),
                          Text(
                            'Выучено',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 12),

              // Пример использования
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.format_quote, size: 14, color: Colors.grey),
                        SizedBox(width: 6),
                        Text(
                          'Пример:',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      example,
                      style: const TextStyle(
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Ассоциации
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Ассоциации:',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: associations
                        .map((association) => Chip(
                      label: Text(
                        association,
                        style: const TextStyle(fontSize: 11),
                      ),
                      backgroundColor: Colors.white.withOpacity(0.7),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      visualDensity: VisualDensity.compact,
                    ))
                        .toList(),
                  ),
                ],
              ),

              // Кнопки действий
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _editContext(context, word, example, associations),
                      icon: const Icon(Icons.edit, size: 14),
                      label: const Text('Изменить'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        side: BorderSide(color: iconColors[colorIndex]),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _practiceWord(context, word),
                      icon: const Icon(Icons.play_arrow, size: 14),
                      label: const Text('Практика'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        backgroundColor: iconColors[colorIndex],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getWordIcon(String word) {
    if (word == 'Apple' || word == 'Banana' || word == 'Orange') {
      return Icons.restaurant;
    } else if (word == 'Dog' || word == 'Cat' || word == 'Elephant') {
      return Icons.pets;
    } else if (word == 'Red' || word == 'Blue' || word == 'Green') {
      return Icons.palette;
    } else if (word == 'Car' || word == 'Bus' || word == 'Train') {
      return Icons.directions_car;
    } else {
      return Icons.text_fields;
    }
  }

  void _editContext(BuildContext context, Word word, String currentExample, List<String> currentAssociations) {
    final exampleController = TextEditingController(text: currentExample);
    final associationsController = TextEditingController(text: currentAssociations.join(', '));

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Редактировать контекст: ${word.word}'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: exampleController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Пример использования',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: associationsController,
                decoration: const InputDecoration(
                  labelText: 'Ассоциации (через запятую)',
                  border: OutlineInputBorder(),
                  hintText: 'fruit, healthy, red, sweet',
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () {
              // Здесь будет сохранение изменений
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Контекст для "${word.word}" обновлён'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            child: const Text('Сохранить'),
          ),
        ],
      ),
    );
  }

  void _practiceWord(BuildContext context, Word word) {
    final topic = TopicsRepository().selectedTopic;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Практика: ${word.word}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Выберите режим практики:'),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  context.push(
                    '/flashcard',
                    extra: {'topic': topic, 'learningNew': false},
                  );
                },
                icon: const Icon(Icons.flash_on),
                label: const Text('Карточки'),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  _showWritingPractice(context, word);
                },
                icon: const Icon(Icons.create),
                label: const Text('Написание'),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Закрыть'),
          ),
        ],
      ),
    );
  }

  void _showWritingPractice(BuildContext context, Word word) {
    final answerController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Практика написания'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Перевод: ${word.translation}'),
            const SizedBox(height: 16),
            TextField(
              controller: answerController,
              decoration: const InputDecoration(
                labelText: 'Напишите слово на английском',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Проверить'),
          ),
        ],
      ),
    );
  }
}