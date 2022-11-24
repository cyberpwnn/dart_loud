import 'package:loud/noise/provider/seeded.dart';

class WhiteProvider extends SeededProvider {
  WhiteProvider({required int seed}) : super(seed: seed);

  @override
  bool isScalable() => false;

  @override
  double noise1(double x) {
    int xi = double2Long(x);
    return valCoord1D(seed, xi);
  }

  @override
  double noise2(double x, double y) {
    int xi = double2Long(x);
    int yi = double2Long(y);
    return valCoord2D(seed, xi, yi);
  }

  @override
  double noise3(double x, double y, double z) {
    int xi = double2Long(x);
    int yi = double2Long(y);
    int zi = double2Long(z);
    return valCoord3D(seed, xi, yi, zi);
  }
}
