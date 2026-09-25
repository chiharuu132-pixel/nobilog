// lib/presentation/pages/how_to_use_page.dart
import 'package:flutter/material.dart';

class HowToUsePage extends StatelessWidget {
  const HowToUsePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('使い方ガイド'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          _UsageSectionCard(
            icon: Icons.add_task,
            title: '1. 習慣を作成する',
            description:
                '右下の「＋」ボタンから新しい習慣を作成できます。同時に最大3件まで登録可能です。相棒となる生き物も一緒に選びましょう！',
          ),
          _UsageSectionCard(
            icon: Icons.check_circle_outline,
            title: '2. 毎日の達成を記録する',
            description:
                '習慣を達成したらカードの「達成」ボタンをタップ！日々の頑張りが記録されていきます。\n\n'
                '「超達成」：\n目標以上に頑張ったときに押しましょう！\n\n'
                '「未達成」：\n目標達成できなかったときに押しましょう。\nptはかなり下がってしまいます...'
          ),
          _UsageSectionCard(
            icon: Icons.pets,
            title: '3. 生き物を育てる',
            description:
                '習慣を継続していくと、選んだ生き物が少しずつ成長・進化していきます。どんな姿になるか楽しみに続けましょう。',
          ),
          _UsageSectionCard(
            icon: Icons.workspace_premium,
            title: '4. 卒業名簿',
            description:
                '目標達成や区切りを迎えた習慣は「卒業」させることができます。卒業した習慣と成長した生き物はメニューの「卒業名簿」からいつでも確認できます。',
          ),
          _UsageSectionCard(
            icon: Icons.cloud_sync_outlined,
            title: '5. バックアップと復元',
            description:
                '右上メニューの「バックアップをファイル保存」からデータのバックアップを行えます。機種変更時などに「ファイルから復元」でデータを戻すことができます。',
          ),
        ],
      ),
    );
  }
}

class _UsageSectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _UsageSectionCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 32,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.4,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}