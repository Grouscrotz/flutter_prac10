import 'package:flutter/material.dart';

class AddWordDialog extends StatelessWidget {
  final String topicName;
  final TextEditingController wordController;
  final TextEditingController translationController;
  final VoidCallback onAdd;

  const AddWordDialog({
    super.key,
    required this.topicName,
    required this.wordController,
    required this.translationController,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Добавить слово в "$topicName"'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(controller: wordController, decoration: InputDecoration(labelText: 'Слово')),
          TextField(controller: translationController, decoration: InputDecoration(labelText: 'Перевод')),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text('Отмена')),
        ElevatedButton(
          onPressed: () {
            onAdd();
            Navigator.pop(context);
          },
          child: Text('Добавить'),
        ),
      ],
    );
  }
}

