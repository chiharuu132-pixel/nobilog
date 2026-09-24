// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'presentation/pages/home_page.dart';
import 'presentation/theme/app_theme.dart'; // 作成したテーマファイルをインポート

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: NobilogApp()));
}

class NobilogApp extends StatelessWidget {
  const NobilogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'のびログ',
      // 別ファイルに切り出したテーマを適用
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      
      // 端末の設定（ライト/ダーク）に合わせて自動で切り替える
      themeMode: ThemeMode.system, 
      
      home: const HomePage(),
    );
  }
}