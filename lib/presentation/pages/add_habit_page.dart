// lib/presentation/pages/add_habit_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../widgets/creature_icon_widget.dart';

class AddHabitPage extends ConsumerStatefulWidget {
  const AddHabitPage({super.key});

  @override
  ConsumerState<AddHabitPage> createState() => _AddHabitPageState();
}

class _AddHabitPageState extends ConsumerState<AddHabitPage> {
  final _titleController = TextEditingController();
  
  // 選択された生き物の種族 (初期値: "ham")
  String _selectedSpecies = 'ham';

  // タイトル未入力時のエラーメッセージ保持用
  String? _titleErrorText;

  // 生き物の選択肢定義
  final List<Map<String, String>> _speciesOptions = const [
    {'value': 'ham', 'label': 'ハム', 'description': 'ハムスター、飼いたいですよね'},
    {'value': 'shiba', 'label': 'しば', 'description': '喧嘩でチワワに負けた過去があります'},
    {'value': 'neko', 'label': 'ねこ', 'description': ''},
    {'value': 'nazo', 'label': '？', 'description': '謎の生き物です。育ててみましょう'},
  ];

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final title = _titleController.text.trim();

    // ★ 要件2: タイトルが空の場合にユーザーへ通知＆エラー表示
    if (title.isEmpty) {
      setState(() {
        _titleErrorText = '習慣タイトルを入力してください';
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('習慣タイトルは必須です。'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    // エラー状態をクリア
    setState(() {
      _titleErrorText = null;
    });

    // --- 最大3件までの制約をチェック ---
    final activeHabitsAsync = ref.read(habitListProvider);
    final activeHabitCount = activeHabitsAsync.valueOrNull?.length ?? 0;

    if (activeHabitCount >= 3) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('アクティブな習慣は最大3件までです。'),
            backgroundColor: Colors.orange,
          ),
        );
      }
      return;
    }

    // リポジトリ経由で DB へ保存
    await ref.read(habitRepositoryProvider).createHabit(
          title: title,
          species: _selectedSpecies,
        );

    // リストを更新
    ref.invalidate(habitListProvider);

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('新しい習慣を作成'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. 習慣タイトルの入力欄
            TextField(
              controller: _titleController,
              // ★ 要件1: autofocus を削除（ユーザーがタップするまでキーボードを開かない）
              onChanged: (text) {
                // 入力されたらエラー表記を消す
                if (_titleErrorText != null && text.trim().isNotEmpty) {
                  setState(() {
                    _titleErrorText = null;
                  });
                }
              },
              decoration: InputDecoration(
                labelText: '習慣のタイトル *',
                hintText: '例: 毎朝読書する、筋トレ',
                border: const OutlineInputBorder(),
                helperText: '※最大3件まで登録可能',
                errorText: _titleErrorText, // ★ 未入力時に赤文字でエラー表示
              ),
            ),
            const SizedBox(height: 32),

            // 2. 生き物選択のラベル
            Text(
              '育てる生き物を選ぶ',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),

            // 3. 生き物選択カード / ラジオのリスト
            Column(
              children: _speciesOptions.map((option) {
                final value = option['value']!;
                final label = option['label']!;
                final description = option['description']!;
                final isSelected = _selectedSpecies == value;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _selectedSpecies = value;
                      });
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isSelected
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).dividerColor,
                          width: isSelected ? 2 : 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        color: isSelected
                            ? Theme.of(context).colorScheme.primary.withOpacity(0.05)
                            : Theme.of(context).cardColor,
                      ),
                      child: Row(
                        children: [
                          // 生き物アイコン（Stage 1 の状態を表示）
                          CreatureIconWidget(
                            species: value,
                            stage: 1,
                            radius: 24,
                          ),
                          const SizedBox(width: 16),

                          // 名称と説明文
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  label,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                if (description.isNotEmpty) ...[
                                  const SizedBox(height: 4),
                                  Text(
                                    description,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Theme.of(context).textTheme.bodySmall?.color,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),

                          // ラジオボタンアイコン
                          Radio<String>(
                            value: value,
                            groupValue: _selectedSpecies,
                            onChanged: (val) {
                              if (val != null) {
                                setState(() {
                                  _selectedSpecies = val;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            
            const SizedBox(height: 40),
            
            // 4. 作成ボタン
            SizedBox(
              width: double.infinity,
              height: 50,
              child: FilledButton(
                onPressed: _submit,
                child: const Text(
                  '作成する',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}