// lib/presentation/pages/home_page.dart
import 'dart:io';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../app/providers.dart';
import '../widgets/habit_card_widget.dart';
import 'add_habit_page.dart';
import 'archived_habits_page.dart';
import 'how_to_use_page.dart'; // ★ 使い方ページをインポート

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitsAsync = ref.watch(habitListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('のびログ'),
        actions: [
          // ★ 使い方（iマーク）ボタンを追加
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: '使い方',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HowToUsePage(),
                ),
              );
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) => _handleMenuSelection(context, ref, value),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'export',
                child: Text('バックアップをファイル保存'),
              ),
              const PopupMenuItem(
                value: 'import',
                child: Text('ファイルから復元'),
              ),
            ],
          ),
        ],
      ),
      drawer: _buildDrawer(context, ref),
      body: habitsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('エラーが発生しました: $error')),
        data: (habits) {
          if (habits.isEmpty) {
            return const Center(child: Text('右下のボタンから習慣を追加してください（最大3件）'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: habits.length,
            itemBuilder: (context, index) {
              return HabitCardWidget(habit: habits[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddHabitPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.green),
            child: Text(
              'のびログ メニュー',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('ホーム (アクティブな習慣)'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.workspace_premium),
            title: const Text('卒業名簿'),
            onTap: () {
              Navigator.pop(context);
              ref.invalidate(archivedHabitListProvider);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ArchivedHabitsPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _handleMenuSelection(
      BuildContext context, WidgetRef ref, String value) async {
    if (value == 'export') {
      final jsonStr = await ref.read(backupServiceProvider).exportToJson();
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/nobilog_backup.json');
      await file.writeAsString(jsonStr);

      if (context.mounted) {
        final box = context.findRenderObject() as RenderBox?;
        await Share.shareXFiles(
          [XFile(file.path)],
          text: 'のびログ バックアップデータ',
          sharePositionOrigin:
              box != null ? box.localToGlobal(Offset.zero) & box.size : null,
        );
      }
    } else if (value == 'import') {
      const typeGroup = XTypeGroup(
        label: 'JSONs',
        extensions: ['json'],
        uniformTypeIdentifiers: ['public.json'],
      );
      final XFile? file = await openFile(acceptedTypeGroups: [typeGroup]);

      if (file != null) {
        try {
          final jsonStr = await file.readAsString();
          await ref.read(backupServiceProvider).importFromJson(jsonStr);

          ref.invalidate(habitListProvider);
          ref.invalidate(habitChartProvider);

          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('ファイルからデータを正常に復元しました。')),
            );
          }
        } catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('復元に失敗しました: $e'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      }
    }
  }
}