import 'package:loud/noise/provider/seeded.dart';

class FlatProvider extends SeededProvider {
  FlatProvider({required int seed}) : super(seed: seed);

  @override
  bool isScalable() => false;

  @override
  bool isFlat() => true;

  @override
  double noise1(double x) => 1.0;

  @override
  double noise2(double x, double y) => 1.0;

  @override
  double noise3(double x, double y, double z) => 1.0;
}
