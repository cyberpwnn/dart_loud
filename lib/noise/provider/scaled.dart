import 'package:loud/noise/noise_plane.dart';

class ScaledProvider extends NoisePlane {
  final NoisePlane generator;
  final double scaleValue;

  ScaledProvider({required this.generator, this.scaleValue = 1.0});

  @override
  double noise1(double x) {
    return generator.noise1(x * scaleValue);
  }

  @override
  double noise2(double x, double y) {
    return generator.noise2(x * scaleValue, y * scaleValue);
  }

  @override
  double noise3(double x, double y, double z) {
    return generator.noise3(x * scaleValue, y * scaleValue, z * scaleValue);
  }

  @override
  double getMaxOutput() {
    return generator.getMaxOutput();
  }

  @override
  double getMinOutput() {
    return generator.getMinOutput();
  }
}
