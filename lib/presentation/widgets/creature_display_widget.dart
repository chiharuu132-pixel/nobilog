import 'package:flutter/material.dart';

class CreatureDisplayWidget extends StatelessWidget {
  final String species;
  final int stage;
  final double scale;
  final double height;

  const CreatureDisplayWidget({
    super.key,
    required this.species,
    required this.stage,
    this.scale = 1.0,
    this.height = 110.0, // グラフと同じ高さ
  });

  @override
  Widget build(BuildContext context) {
    final String assetPath = 'assets/images/creatures/${species}_$stage.png';
    final String emoji = _getCreatureEmoji(species, stage);

    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        // 少し色をつけて、メインの表示エリア感を出します
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Transform.scale(
          scale: scale, // キャラクターのスケール適用
          child: Image.asset(
            assetPath,
            // デカデカと表示するため、高さの90%ほどを使います
            height: height * 0.9, 
            fit: BoxFit.contain, // 縦横比を維持してはみ出さないように
            errorBuilder: (context, error, stackTrace) {
              // 画像がない場合のフォールバック（大きな絵文字）
              return Text(
                emoji,
                style: TextStyle(fontSize: height * 0.6),
              );
            },
          ),
        ),
      ),
    );
  }

  /// 画像がない場合・読み込み失敗時のバックアップ用絵文字
  String _getCreatureEmoji(String species, int stage) {
    switch (species) {
      case 'ham':
        return '🐹';
      case 'shiba':
        if (stage <= 1) return '🐾';
        return '🐕';
      case 'neko':
        if (stage <= 1) return '🐾';
        if (stage == 2) return '🐱';
        return '🦁';
      default:
        if (stage <= 1) return '🌱';
        if (stage == 2) return '🌿';
        return '✨';
    }
  }
}