import 'package:loud/interpolator/interpolator.dart';
import 'package:loud/noise/noise_plane.dart';

class FittedProvider extends NoisePlane {
  final NoisePlane generator;
  final double min;
  final double max;

  FittedProvider({required this.generator, this.min = 0.0, this.max = 1.0});

  @override
  double noise1(double x) {
    return rangeScale(min, max, generator.getMinOutput(),
        generator.getMaxOutput(), generator.noise1(x));
  }

  @override
  double noise2(double x, double y) {
    return rangeScale(min, max, generator.getMinOutput(),
        generator.getMaxOutput(), generator.noise2(x, y));
  }

  @override
  double noise3(double x, double y, double z) {
    return rangeScale(min, max, generator.getMinOutput(),
        generator.getMaxOutput(), generator.noise3(x, y, z));
  }

  @override
  double getMaxOutput() {
    return max;
  }

  @override
  double getMinOutput() {
    return min;
  }
}
