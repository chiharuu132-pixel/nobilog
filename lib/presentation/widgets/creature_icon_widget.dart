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
    // 画像アセットのダミーパスを取得
    final String? assetPath = _getCreatureImagePath(species, stage);
    // フォールバック用の絵文字を取得
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
                  // 画像ファイルが存在しない・読み込めない場合は絵文字を表示する
                  errorBuilder: (context, error, stackTrace) {
                    return Text(
                      emoji,
                      style: TextStyle(fontSize: radius * 0.9),
                    );
                  },
                ),
              )
            : Text(
                emoji,
                style: TextStyle(fontSize: radius * 0.9),
              ),
      ),
    );
  }

  String _normalizeSpecies(String species) {
    switch (species.toLowerCase()) {
      case 'plant':
      case '植物':
        return '1';
      case 'bird':
      case '鳥':
      case 'chick':
        return '2';
      case 'cat':
      case '猫':
        return '3';
      case 'fish':
      case '魚':
        return '3';
      default:
        return species.toLowerCase();
    }
  }

  /// 画像ファイルパスの取得（例: assets/images/creatures/creatureplant_1.png）
  String? _getCreatureImagePath(String species, int stage) {
    final normalized = _normalizeSpecies(species);
    return 'assets/images/creatures/creature${normalized}_$stage.png';
  }

  /// 画像がない場合・読み込み失敗時のバックアップ用絵文字
  String _getCreatureEmoji(String species, int stage) {
    switch (species) {
      case '1':
      case 'plant':
      case '植物':
        if (stage <= 1) return '🌱';
        if (stage == 2) return '🌿';
        return '🌳';

      case '2':
      case 'bird':
      case '鳥':
      case 'chick':
        if (stage <= 1) return '🐣';
        if (stage == 2) return '🐥';
        return '🐔';

      case '3':
      case 'cat':
      case '猫':
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