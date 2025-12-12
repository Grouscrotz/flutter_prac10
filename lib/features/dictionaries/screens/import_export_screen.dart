import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ImportExportScreen extends StatelessWidget {
  const ImportExportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFcfd9df),
      appBar: AppBar(
        title: const Text('Импорт словарей'),
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
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.download,
                        color: Colors.blue,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Добавить словари',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Выберите способ добавления новых слов',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Способы импорта
            const Text(
              'Способы импорта',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            Expanded(
              child: ListView(
                children: [
                  _buildImportOption(
                    icon: Icons.text_fields,
                    title: 'Скопировать текст',
                    subtitle: 'Вставьте список слов в формате "слово - перевод"',
                    color: Colors.blue,
                    onTap: () => _showTextImport(context),
                  ),

                  _buildImportOption(
                    icon: Icons.library_books,
                    title: 'Готовые шаблоны',
                    subtitle: 'Популярные темы для быстрого старта',
                    color: Colors.green,
                    onTap: () => _showTemplates(context),
                  ),

                  _buildImportOption(
                    icon: Icons.file_present,
                    title: 'Файл словаря',
                    subtitle: 'Загрузите файл в формате JSON',
                    color: Colors.orange,
                    onTap: () => _importFromFile(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImportOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      ),
    );
  }

  void _showTextImport(BuildContext context) {
    final textController = TextEditingController();
    String? selectedTopic;

    showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Импорт из текста'),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Введите или вставьте слова в формате:\nслово - перевод',
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: textController,
                      maxLines: 8,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'apple - яблоко\nbanana - банан\ncar - машина',
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.folder, size: 20, color: Colors.blue),
                        const SizedBox(width: 8),
                        const Text('Добавить в тему:'),
                        const SizedBox(width: 12),
                        Expanded(
                          child: DropdownButton<String>(
                            value: selectedTopic,
                            hint: const Text('Выберите тему'),
                            isExpanded: true,
                            items: const [
                              DropdownMenuItem(
                                value: 'fruits',
                                child: Text('Фрукты'),
                              ),
                              DropdownMenuItem(
                                value: 'animals',
                                child: Text('Животные'),
                              ),
                              DropdownMenuItem(
                                value: 'new',
                                child: Text('Создать новую'),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedTopic = value;
                              });
                            },
                          ),
                        ),
                      ],
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
                    final lines = textController.text.split('\n');
                    int importedCount = 0;

                    for (final line in lines) {
                      if (line.contains('-')) {
                        importedCount++;
                      }
                    }

                    Navigator.pop(context);

                    if (importedCount > 0) {
                      _showImportSuccessDialog(
                        context,
                        title: 'Импорт завершён',
                        message: 'Успешно импортировано $importedCount слов',
                        details: 'Слова добавлены в выбранную тему',
                      );
                    } else {
                      _showErrorDialog(
                        context,
                        title: 'Ошибка формата',
                        message: 'Не удалось распознать слова.\nПроверьте формат: слово - перевод',
                      );
                    }
                  },
                  child: const Text('Импортировать'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showTemplates(BuildContext context) {
    final templates = [
      {
        'name': 'Английский для путешествий',
        'words': 50,
        'icon': Icons.flight,
        'description': 'Слова для аэропорта, отеля, ресторана'
      },
      {
        'name': 'Бизнес-английский',
        'words': 40,
        'icon': Icons.business,
        'description': 'Деловые встречи, переговоры, презентации'
      },
      {
        'name': 'IT и технологии',
        'words': 60,
        'icon': Icons.computer,
        'description': 'Термины для разработчиков и IT-специалистов'
      },
      {
        'name': 'Еда и рестораны',
        'words': 35,
        'icon': Icons.restaurant,
        'description': 'Меню, ингредиенты, кулинарные термины'
      },
      {
        'name': 'Спорт и фитнес',
        'words': 30,
        'icon': Icons.sports,
        'description': 'Виды спорта, упражнения, инвентарь'
      },
      {
        'name': 'Медицина',
        'words': 45,
        'icon': Icons.medical_services,
        'description': 'Симптомы, лечение, визит к врачу'
      },
    ];

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Готовые шаблоны'),
        content: SizedBox(
          width: double.maxFinite,
          height: 400,
          child: ListView.builder(
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
                    child: Icon(
                      template['icon'] as IconData,
                      color: Colors.blue,
                      size: 24,
                    ),
                  ),
                  title: Text(template['name'] as String),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(template['description'] as String),
                      const SizedBox(height: 4),
                      Text(
                        '${template['words']} слов',
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  trailing: const Icon(Icons.add_circle, color: Colors.green),
                  onTap: () {
                    Navigator.pop(context);

                    // Показать прогресс импорта
                    _showLoadingDialog(context);

                    // Имитация загрузки
                    Future.delayed(const Duration(seconds: 1), () {
                      Navigator.pop(context); // Закрыть loading

                      _showImportSuccessDialog(
                        context,
                        title: 'Шаблон добавлен',
                        message: 'Шаблон "${template['name']}" успешно импортирован',
                        details: 'Добавлено ${template['words']} слов в ваш словарь',
                      );
                    });
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
          ),
        ],
      ),
    );
  }

  void _scanQRCode(BuildContext context) {
    bool isScanning = true;

    showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Сканирование QR-кода'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.qr_code_scanner,
                          size: 60,
                          color: isScanning ? Colors.blue : Colors.green,
                        ),
                        const SizedBox(height: 16),
                        if (isScanning)
                          const Column(
                            children: [
                              Text(
                                'Сканирование...',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Наведите камеру на QR-код\nсловаря',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.grey),
                              ),
                              SizedBox(height: 16),
                              CircularProgressIndicator(),
                            ],
                          )
                        else
                          const Column(
                            children: [
                              Icon(Icons.check_circle, size: 40, color: Colors.green),
                              SizedBox(height: 12),
                              Text(
                                'QR-код распознан!',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Получено 28 слов из словаря',
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              actions: [
                if (isScanning) ...[
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Отмена'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isScanning = false;
                      });

                      // Имитация успешного сканирования через 2 секунды
                      Future.delayed(const Duration(seconds: 2), () {
                        Navigator.pop(context);
                        _showImportSuccessDialog(
                          context,
                          title: 'Импорт из QR-кода',
                          message: 'Словарь успешно импортирован',
                          details: 'Получено 28 слов от пользователя "Alex"',
                        );
                      });
                    },
                    child: const Text('Имитировать сканирование'),
                  ),
                ] else ...[
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Закрыть'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _showImportSuccessDialog(
                        context,
                        title: 'Импорт из QR-кода',
                        message: 'Словарь успешно импортирован',
                        details: 'Получено 28 слов от пользователя "Alex"',
                      );
                    },
                    child: const Text('Добавить словарь'),
                  ),
                ],
              ],
            );
          },
        );
      },
    );
  }

  void _importFromFile(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Загрузка файла'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                children: [
                  Icon(Icons.insert_drive_file, size: 60, color: Colors.blue),
                  SizedBox(height: 16),
                  Text(
                    'Поддерживаемые форматы:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '• JSON файлы словарей\n• Текстовые файлы (.txt)\n• CSV таблицы',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Выберите файл для импорта:',
              style: TextStyle(color: Colors.grey),
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
              Navigator.pop(context);

              // Показать прогресс загрузки
              _showLoadingDialog(context);

              // Имитация загрузки файла
              Future.delayed(const Duration(seconds: 2), () {
                Navigator.pop(context); // Закрыть loading

                _showImportSuccessDialog(
                  context,
                  title: 'Файл успешно загружен',
                  message: 'Файл "english_vocabulary.json" обработан',
                  details: 'Импортировано 42 слова в 3 темы',
                );
              });
            },
            child: const Text('Выбрать файл'),
          ),
        ],
      ),
    );
  }

  void _showAppsImport(BuildContext context) {
    final apps = [
      {
        'name': 'Anki',
        'icon': Icons.flash_on,
        'color': Colors.blue,
        'format': 'Формат .apkg'
      },
      {
        'name': 'Quizlet',
        'icon': Icons.school,
        'color': Colors.red,
        'format': 'Экспорт CSV'
      },
      {
        'name': 'Memrise',
        'icon': Icons.memory,
        'color': Colors.purple,
        'format': 'Текстовый файл'
      },
      {
        'name': 'Lingualeo',
        'icon': Icons.pets,
        'color': Colors.orange,
        'format': 'Экспорт словаря'
      },
    ];

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Импорт из других приложений'),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Выберите приложение для импорта словарей:',
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.5,
                children: apps.map((app) {
                  return Card(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        Navigator.pop(context);

                        _showLoadingDialog(context);

                        Future.delayed(const Duration(seconds: 1), () {
                          Navigator.pop(context);

                          _showImportSuccessDialog(
                            context,
                            title: 'Импорт из ${app['name']}',
                            message: 'Словарь успешно конвертирован',
                            details: 'Формат: ${app['format']}\nДобавлено 35 слов',
                          );
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              app['icon'] as IconData,
                              color: app['color'] as Color,
                              size: 30,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              app['name'] as String,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              app['format'] as String,
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
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

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.blue,
            strokeWidth: 3,
          ),
        ),
      ),
    );
  }

  void _showImportSuccessDialog(
      BuildContext context, {
        required String title,
        required String message,
        required String details,
      }) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, size: 60, color: Colors.green),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                details,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 13),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Продолжить'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.pop(); // Вернуться на экран словарей
            },
            child: const Text('Перейти к словарям'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(
      BuildContext context, {
        required String title,
        required String message,
      }) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error, size: 60, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}