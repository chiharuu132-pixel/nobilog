// lib/presentation/theme/app_theme.dart
import 'package:flutter/material.dart';

class AppTheme {
  static const Color _seedColor = Color.fromARGB(255, 250, 250, 250);

  // -------------------------
  // ライトモードのテーマ
  // -------------------------
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: Brightness.light,
    ),
    
    // AppBar（ヘッダー）の共通デザイン
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
    ),
    
    // ★ CardTheme -> CardThemeData に変更
    cardTheme: CardThemeData(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    
    // ボタンの共通デザイン
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
  );

  // -------------------------
  // ダークモードのテーマ
  // -------------------------
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: Brightness.dark,
    ),
    
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
    ),
    
    // ★ CardTheme -> CardThemeData に変更
    cardTheme: CardThemeData(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
  );
}