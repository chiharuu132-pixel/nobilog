import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart'; // habitRepositoryProvider などがある場所
import '../widgets/creature_icon_widget.dart';

class AddHabitDialog extends ConsumerStatefulWidget {
  const AddHabitDialog({super.key});

  @override
  ConsumerState<AddHabitDialog> createState() => _AddHabitDialogState();
}

class _AddHabitDialogState extends ConsumerState<AddHabitDialog> {
  final _titleController = TextEditingController();
  
  // 選択された生き物の種族 (初期値: "1")
  String _selectedSpecies = 'ham';

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
    if (title.isEmpty) return;

    // リポジトリ経由で DB へ保存
    await ref.read(habitRepositoryProvider).createHabit(
          title: title,
          species: _selectedSpecies, // "ham"など
        );

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('新しい習慣を作成'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. 習慣タイトルの入力欄
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: '習慣のタイトル',
                hintText: '例: 毎朝読書する、筋トレ',
                border: OutlineInputBorder(),
              ),
              autofocus: true,
            ),
            const SizedBox(height: 20),

            // 2. 生き物選択のラベル
            Text(
              '育てる生き物を選ぶ',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 10),

            // 3. 生き物選択カード / ラジオのリスト
            Column(
              children: _speciesOptions.map((option) {
                final value = option['value']!;
                final label = option['label']!;
                final description = option['description']!;
                final isSelected = _selectedSpecies == value;

                return InkWell(
                  onTap: () {
                    setState(() {
                      _selectedSpecies = value;
                    });
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey.shade300,
                        width: isSelected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary.withOpacity(0.05)
                          : Colors.transparent,
                    ),
                    child: Row(
                      children: [
                        // 生き物アイコン（Stage 1 の状態を表示）
                        CreatureIconWidget(
                          species: value,
                          stage: 1,
                          radius: 20,
                        ),
                        const SizedBox(width: 12),

                        // 名称と説明文
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                label,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                description,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey.shade600,
                                ),
                              ),
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
                );
              }).toList(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('キャンセル'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('作成'),
        ),
      ],
    );
  }
}
