import 'package:loud/noise/noise_plane.dart';

class WarpedProvider extends NoisePlane {
  final NoisePlane generator;
  final NoisePlane warpValue;
  final double scaleValue;
  final double multiplier;

  WarpedProvider(
      {required this.generator,
      required this.warpValue,
      this.scaleValue = 1.0,
      this.multiplier = 1.0});

  @override
  double noise1(double x) {
    return generator
        .noise1((warpValue.noise1(x * scaleValue) * multiplier) + x);
  }

  @override
  double noise2(double x, double y) {
    return generator.noise2(
        (warpValue.noise2(x * scaleValue, y * scaleValue) * multiplier) + x,
        (warpValue.noise2(y * scaleValue, -x * scaleValue) * multiplier) + y);
  }

  @override
  double noise3(double x, double y, double z) {
    return generator.noise3(
        (warpValue.noise3(-x * scaleValue, y * scaleValue, z * scaleValue) *
                multiplier) +
            x,
        (warpValue.noise3(y * scaleValue, -z * scaleValue, x * scaleValue) *
                multiplier) +
            y,
        (warpValue.noise3(z * scaleValue, x * scaleValue, -y * scaleValue) *
                multiplier) +
            z);
  }

  @override
  double getMaxOutput() => generator.getMaxOutput();

  @override
  double getMinOutput() => generator.getMinOutput();
}
