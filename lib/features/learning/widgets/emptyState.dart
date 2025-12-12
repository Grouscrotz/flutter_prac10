import 'package:flutter/material.dart';

class EmptyStateScreen extends StatelessWidget {
  const EmptyStateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Карточки')),
      body: const Center(
        child: Text(
          'Нет слов для изучения',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
