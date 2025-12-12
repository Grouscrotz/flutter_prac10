import 'package:flutter/material.dart';
import 'package:prac9/models/word.dart';

class WordCard extends StatelessWidget {
  final Word word;
  final bool showTranslation;
  final VoidCallback onShowTranslation;
  final VoidCallback onShowAgain;
  final VoidCallback onRemembered;

  const WordCard({
    super.key,
    required this.word,
    required this.showTranslation,
    required this.onShowTranslation,
    required this.onShowAgain,
    required this.onRemembered,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              word.word,
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            if (showTranslation)
              Text(
                word.translation,
                style: const TextStyle(fontSize: 28, color: Colors.green),
                textAlign: TextAlign.center,
              )
            else
              ElevatedButton(
                onPressed: onShowTranslation,
                child: const Text('Показать перевод'),
              ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: onShowAgain,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  child: const Text('Показать снова'),
                ),
                ElevatedButton(
                  onPressed: onRemembered,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text('Запомнил'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}