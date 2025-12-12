import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/cupertino.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFcfd9df),
      appBar: AppBar(
        title: const Text('Настройки'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Настройки сохранены'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
            tooltip: 'Сохранить',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Заголовок с иконкой
            Container(
              margin: const EdgeInsets.only(top: 24, bottom: 16),
              child: const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.indigo,
                child: Icon(
                  Icons.settings,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
            const Text(
              'Настройки приложения',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Настройте приложение под свои предпочтения',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),

            // Основные настройки
            _buildSettingsCard(
              title: 'Основные',
              children: [
                _buildSettingItem(
                  icon: Icons.palette,
                  iconColor: Colors.deepPurple,
                  title: 'Тема приложения',
                  subtitle: 'Светлая',
                  trailing: Switch(value: false, onChanged: (_) {}),
                ),
                _buildSettingItem(
                  icon: Icons.language,
                  iconColor: Colors.blue,
                  title: 'Язык интерфейса',
                  subtitle: 'Русский',
                  onTap: () => _showLanguageDialog(context),
                ),
                _buildSettingItem(
                  icon: Icons.notifications,
                  iconColor: Colors.orange,
                  title: 'Уведомления',
                  subtitle: 'Включены',
                  trailing: Switch(value: true, onChanged: (_) {}),
                ),
              ],
            ),

            // Настройки обучения
            _buildSettingsCard(
              title: 'Обучение',
              children: [
                _buildSettingItem(
                  icon: Icons.speed,
                  iconColor: Colors.green,
                  title: 'Скорость обучения',
                  subtitle: 'Средняя',
                  onTap: () => _showSpeedDialog(context),
                ),
                _buildSettingItem(
                  icon: Icons.format_list_numbered,
                  iconColor: Colors.teal,
                  title: 'Слов за сессию',
                  subtitle: '10 слов',
                  onTap: () => _showWordsPerSessionDialog(context),
                ),
                _buildSettingItem(
                  icon: Icons.repeat,
                  iconColor: Colors.pink,
                  title: 'Повторение слов',
                  subtitle: '3 раза',
                  onTap: () => _showRepetitionDialog(context),
                ),
              ],
            ),

            // Управление данными
            _buildSettingsCard(
              title: 'Данные',
              children: [
                _buildSettingItem(
                  icon: Icons.cloud_upload,
                  iconColor: Colors.blueAccent,
                  title: 'Синхронизация',
                  subtitle: 'Автоматическая',
                  trailing: Switch(value: true, onChanged: (_) {}),
                ),
                _buildSettingItem(
                  icon: Icons.backup,
                  iconColor: Colors.amber,
                  title: 'Резервное копирование',
                  subtitle: 'Последнее: сегодня',
                  onTap: () => _showBackupDialog(context),
                ),
                _buildSettingItem(
                  icon: Icons.delete,
                  iconColor: Colors.red,
                  title: 'Очистить кэш',
                  subtitle: '15.2 МБ',
                  onTap: () => _showClearCacheDialog(context),
                ),
              ],
            ),

            // О приложении
            _buildSettingsCard(
              title: 'О приложении',
              children: [
                _buildSettingItem(
                  icon: Icons.info,
                  iconColor: Colors.indigo,
                  title: 'Версия',
                  subtitle: '1.0.0 (Build 45)',
                ),
                _buildSettingItem(
                  icon: Icons.shield,
                  iconColor: Colors.green,
                  title: 'Политика конфиденциальности',
                  onTap: () => _showPrivacyDialog(context),
                ),
                _buildSettingItem(
                  icon: Icons.description,
                  iconColor: Colors.blueGrey,
                  title: 'Условия использования',
                  onTap: () => _showTermsDialog(context),
                ),
                _buildSettingItem(
                  icon: Icons.star,
                  iconColor: Colors.amber,
                  title: 'Оценить приложение',
                  onTap: () => _showRateDialog(context),
                ),
              ],
            ),

            // Кнопка сброса
            Container(
              margin: const EdgeInsets.all(20),
              child: OutlinedButton.icon(
                onPressed: () => _showResetDialog(context),
                icon: const Icon(Icons.restart_alt, color: Colors.red),
                label: const Text(
                  'Сбросить все настройки',
                  style: TextStyle(color: Colors.red),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  side: const BorderSide(color: Colors.red),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // Вспомогательные методы
  Widget _buildSettingsCard({
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: iconColor, size: 24),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: subtitle != null
          ? Text(
        subtitle,
        style: const TextStyle(color: Colors.grey, fontSize: 13),
      )
          : null,
      trailing: trailing ?? const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
    );
  }

  // Диалоги (UI-заглушки)
  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Выбор языка'),
        content: SizedBox(
          height: 200,
          child: ListView(
            children: [
              _buildLanguageOption('Русский', true),
              _buildLanguageOption('English', false),
              _buildLanguageOption('Español', false),
              _buildLanguageOption('Deutsch', false),
              _buildLanguageOption('Français', false),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Сохранить'),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(String language, bool selected) {
    return ListTile(
      title: Text(language),
      trailing: selected
          ? const Icon(Icons.check_circle, color: Colors.green)
          : null,
      onTap: () {},
    );
  }

  void _showSpeedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Скорость обучения'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Выберите подходящую скорость показа карточек:'),
            const SizedBox(height: 20),
            Slider(
              value: 2,
              min: 1,
              max: 5,
              divisions: 4,
              label: 'Средняя',
              onChanged: (_) {},
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Медленно', style: TextStyle(color: Colors.grey)),
                Text('Средняя', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Быстро', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Применить'),
          ),
        ],
      ),
    );
  }

  void _showWordsPerSessionDialog(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 250,
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: CupertinoPicker(
                itemExtent: 40,
                onSelectedItemChanged: (_) {},
                children: const [
                  Text('5 слов'),
                  Text('10 слов'),
                  Text('15 слов'),
                  Text('20 слов'),
                  Text('25 слов'),
                  Text('30 слов'),
                ],
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Готово'),
            ),
          ],
        ),
      ),
    );
  }

  void _showRepetitionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => SimpleDialog(
        title: const Text('Повторение слов'),
        children: [
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context),
            child: const Text('1 раз'),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context),
            child: const Text('3 раза (рекомендуется)'),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context),
            child: const Text('5 раз'),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context),
            child: const Text('Пока не запомню'),
          ),
        ],
      ),
    );
  }

  void _showBackupDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Резервное копирование'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.cloud_done, size: 60, color: Colors.green),
            SizedBox(height: 16),
            Text('Последняя резервная копия создана сегодня в 14:30'),
            SizedBox(height: 8),
            Text('Всего сохранено: 245 слов в 15 темах'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Создать копию сейчас'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Восстановить'),
          ),
        ],
      ),
    );
  }

  void _showClearCacheDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Очистить кэш?'),
        content: const Text('Это освободит 15.2 МБ на устройстве. Кэш будет автоматически восстановлен при необходимости.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Кэш успешно очищен'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Очистить'),
          ),
        ],
      ),
    );
  }

  void _showPrivacyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Политика конфиденциальности'),
        content: const SingleChildScrollView(
          child: Text(
            'Ваши данные в безопасности. Мы не передаем личную информацию третьим лицам. Все данные хранятся локально на вашем устройстве. При использовании облачной синхронизации данные шифруются. Вы можете в любой момент удалить свои данные через настройки.',
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

  void _showTermsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Условия использования'),
        scrollable: true,
        content: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('1. Приложение предназначено для личного использования'),
            SizedBox(height: 8),
            Text('2. Вы можете создавать и удалять свои словари'),
            SizedBox(height: 8),
            Text('3. Рекомендуется регулярно делать резервные копии'),
            SizedBox(height: 8),
            Text('4. Приложение может обновляться без предупреждения'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Принимаю'),
          ),
        ],
      ),
    );
  }

  void _showRateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Оцените приложение'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.star, size: 50, color: Colors.amber),
            const SizedBox(height: 16),
            const Text('Нравится приложение? Оставьте оценку!'),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                    (index) => Icon(
                  Icons.star,
                  size: 30,
                  color: index < 4 ? Colors.amber : Colors.grey,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Позже'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Спасибо за вашу оценку!'),
                ),
              );
            },
            child: const Text('Оценить'),
          ),
        ],
      ),
    );
  }

  void _showResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Сбросить настройки?'),
        content: const Text('Все настройки будут возвращены к значениям по умолчанию. Ваши словари и прогресс останутся нетронутыми.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Настройки сброшены'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Сбросить'),
          ),
        ],
      ),
    );
  }
}