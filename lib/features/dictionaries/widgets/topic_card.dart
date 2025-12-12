import 'package:flutter/material.dart';
import 'package:prac9/models/topic.dart';

class TopicCard extends StatelessWidget {
  final Topic topic;
  final bool selected;
  final VoidCallback onTap;
  final VoidCallback onResetProgress;
  final VoidCallback onShowWords;
  final VoidCallback onAddWord;

  TopicCard({
    required this.topic,
    required this.selected,
    required this.onTap,
    required this.onResetProgress,
    required this.onShowWords,
    required this.onAddWord,
  });

  @override
  Widget build(BuildContext context) {
    return Card(color: selected ? Colors.indigo.shade100 : Colors.white,
      child: ListTile(title: Text(topic.name),
        trailing: Row(mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(icon: Icon(Icons.list),
              onPressed: onShowWords,
              tooltip: 'Показать все слова',
            ),
            IconButton(icon: Icon(Icons.add),
              onPressed: onAddWord,
              tooltip: 'Добавить слово',
            ),
            if (selected)IconButton(icon: Icon(Icons.restart_alt),
                tooltip: 'Сбросить прогресс',
                onPressed: onResetProgress,
              ),
            if (selected) Icon(Icons.check),
          ],
        ), onTap: onTap,
      ),
    );
  }
}
