import 'dart:math';
import 'dart:typed_data';

class RandomGenerator {
  final Random _random;

  RandomGenerator([Random? random]) : _random = random ?? Random();

  /// シード（ByteArray）から再現可能なRandomインスタンスを生成
  factory RandomGenerator.fromSeed(Uint8List seed) {
    int seedValue = 0;
    for (int i = 0; i < seed.length && i < 8; i++) {
      seedValue = (seedValue << 8) | seed[i];
    }
    return RandomGenerator(Random(seedValue));
  }

  /// ボックス＝ミュラー法による正規分布 N(mu, sigma) の生成
  double generateNormal(double mu, double sigma) {
    double u1 = 1.0 - _random.nextDouble();
    double u2 = 1.0 - _random.nextDouble();
    double z0 = sqrt(-2.0 * log(u1)) * cos(2.0 * pi * u2);
    return z0 * sigma + mu;
  }
}