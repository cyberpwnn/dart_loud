import 'package:loud/noise/noise_plane.dart';

class OctaveProvider extends NoisePlane {
  final NoisePlane generator;
  final int octaves;
  final double gain;
  double multiplier;

  OctaveProvider({required this.generator, this.octaves = 1, this.gain = 0.5})
      : multiplier = 1.0 / octaves.toDouble();

  @override
  double noise1(double x) {
    double n = generator.noise1(x);

    for (int i = 1; i < octaves; i++) {
      n += generator.noise1((x + (i * 100000)) * gain * i);
    }

    return n * multiplier;
  }

  @override
  double noise2(double x, double y) {
    double n = generator.noise2(x, y);

    for (int i = 1; i < octaves; i++) {
      n += generator.noise2(
          (x + (i * 100000)) * gain * i, (y + (i * 100000)) * gain * i);
    }

    return n * multiplier;
  }

  @override
  double noise3(double x, double y, double z) {
    double n = generator.noise3(x, y, z);

    for (int i = 1; i < octaves; i++) {
      n += generator.noise3((x + (i * 100000)) * gain * i,
          (y + (i * 100000)) * gain * i, (z + (i * 100000)) * gain * i);
    }

    return n * multiplier;
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
