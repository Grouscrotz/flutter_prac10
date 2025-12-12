import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'appObserver.dart';
import 'features/dictionaries/screens/dictionaries_screen.dart';
import 'features/dictionaries/screens/import_export_screen.dart';
import 'features/learning/screens/context_associations_screen.dart';
import 'features/learning/screens/flashcard/flashcard_screen.dart';
import 'features/learning/screens/learning_screen.dart';
import 'features/learning/screens/repetition_planner_screen.dart';
import 'features/progress/screens/progress_screen.dart';
import 'features/learning/screens/topic_settings/topic_settings_screen.dart';
import 'features/learning/screens/word_preview/word_preview_screen.dart';
import 'features/settings/settings_screen.dart';
import 'features/users/auth_screen.dart';
import 'features/users/login_screen.dart';
import 'features/users/register_screen.dart';
import 'models/topic.dart';

void main() {
  Bloc.observer = const AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final _router = GoRouter(
    initialLocation: '/auth',
    routes: [
      GoRoute(path: '/auth', builder: (_, __) => const AuthScreen()),
      GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
      GoRoute(path: '/register', builder: (_, __) => const RegisterScreen()),
      GoRoute(path: '/dictionaries', builder: (_, __) => const DictionariesPage()),
      GoRoute(path: '/learning', builder: (_, __) => const LearningPage()),
      GoRoute(path: '/progress', builder: (_, __) => const ProgressPage()),
      GoRoute(path: '/settings', builder: (_, __) => const SettingsScreen()),
      GoRoute(path: '/topic_settings', builder: (_, __) => const TopicSettingsPage()),
      GoRoute(path: '/word_preview', builder: (_, __) => const WordPreviewPage()),
      GoRoute(path: '/import_export', builder: (_, __) => const ImportExportScreen()),
      GoRoute(path: '/repetition_planner', builder: (_, __) => const RepetitionPlannerScreen()),
      GoRoute(path: '/context_associations', builder: (_, __) => const ContextAssociationsScreen()),
      GoRoute(
        path: '/flashcard',
        builder: (_, state) {
          final extra = state.extra as Map<String, dynamic>;
          return FlashCardPage(
            topic: extra['topic'] as Topic,
            learningNew: extra['learningNew'] as bool,
          );
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Приложение для изучения иностранных слов',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFcfd9df),
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}