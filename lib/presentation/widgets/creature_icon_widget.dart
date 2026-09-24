import 'package:flutter/material.dart';

class CreatureIconWidget extends StatelessWidget {
  final String species;
  final int stage;
  final double scale;
  final double radius;

  const CreatureIconWidget({
    super.key,
    required this.species,
    required this.stage,
    this.scale = 1.0,
    this.radius = 22.0,
  });

  @override
  Widget build(BuildContext context) {
    final String? assetPath = _getCreatureImagePath(species, stage);
    final String emoji = _getCreatureEmoji(species, stage);

    return Transform.scale(
      scale: scale,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: _getBackgroundColor(stage),
        child: assetPath != null
            ? ClipOval(
                child: Image.asset(
                  assetPath,
                  width: radius * 2,
                  height: radius * 2,
                  fit: BoxFit.cover,
                  // 実際に画像の読み込みに失敗した時だけ実行される
                  errorBuilder: (context, error, stackTrace) {
                    debugPrint(
                      '【フォールバック発生】画像が読み込めないため絵文字を表示します: '
                      'path = $assetPath, species = $species, stage = $stage',
                    );
                    return Text(
                      emoji,
                      style: TextStyle(fontSize: radius * 0.9),
                    );
                  },
                ),
              )
            : Builder(
                builder: (context) {
                  debugPrint(
                    '【フォールバック発生】assetPath が null のため絵文字を表示します: '
                    'species = $species, stage = $stage',
                  );
                  return Text(
                    emoji,
                    style: TextStyle(fontSize: radius * 0.9),
                  );
                },
              ),
      ),
    );
  }

  /// 画像ファイルパスの取得
  String? _getCreatureImagePath(String species, int stage) {
    return 'assets/images/creatures/${species}_$stage.png';
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

  /// 進化段階に応じた背景色
  Color _getBackgroundColor(int stage) {
    switch (stage) {
      case 1:
        return Colors.green.shade100;
      case 2:
        return Colors.amber.shade100;
      case 3:
        return Colors.orange.shade200;
      default:
        return Colors.grey.shade200;
    }
  }
}