import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/providers.dart'; // 先ほど作成したファイル

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // データベースから非同期で読み込まれた状態を監視
    final habitsAsync = ref.watch(habitListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('のびログ (DB連携版)'),
      ),
      body: habitsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('エラーが発生しました: $error')),
        data: (habits) {
          if (habits.isEmpty) {
            return const Center(child: Text('右下のボタンから習慣を追加してください'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: habits.length,
            itemBuilder: (context, index) {
              final habit = habits[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        habit.title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text('進化段階: ${habit.stage}'),
                          const SizedBox(width: 16),
                          Text(
                            '累積ポイント: ${habit.totalPoints} pt',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // lib/main.dart の Wrap Widget部分に追加
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          ElevatedButton(
                            onPressed: () => ref.read(habitListProvider.notifier).recordStandard(habit.habitId),
                            child: const Text('通常達成', textAlign: TextAlign.center),
                          ),
                          ElevatedButton(
                            onPressed: () => ref.read(habitListProvider.notifier).recordMinimum(habit.habitId),
                            child: const Text('最低達成', textAlign: TextAlign.center),
                          ),
                          OutlinedButton(
                            onPressed: () => ref.read(habitListProvider.notifier).recordRest(habit.habitId),
                            child: const Text('休息', textAlign: TextAlign.center),
                          ),
                          FilledButton.tonal(
                            onPressed: () => ref.read(habitListProvider.notifier).recordMissed(habit.habitId, habit.totalPoints),
                            style: FilledButton.styleFrom(backgroundColor: Colors.red.shade100),
                            child: const Text('未達成', textAlign: TextAlign.center, style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // テスト用のダミー習慣を登録
          ref.read(habitListProvider.notifier).addDummyHabit('テスト習慣 ${DateTime.now().second}');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}