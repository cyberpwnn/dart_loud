import 'dart:math';

import 'package:loud/noise/noise_plane.dart';

class ExponentProvider extends NoisePlane {
  final NoisePlane generator;
  final double exponentValue;

  ExponentProvider({required this.generator, this.exponentValue = 1.0});

  @override
  double noise1(double x) {
    return pow(generator.noise1(x), exponentValue).toDouble();
  }

  @override
  double noise2(double x, double y) {
    return pow(generator.noise2(x, y), exponentValue).toDouble();
  }

  @override
  double noise3(double x, double y, double z) {
    return pow(generator.noise3(x, y, z), exponentValue).toDouble();
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
