import 'package:loud/noise/noise_plane.dart';
import 'package:loud/noise/provider/seeded.dart';
import 'package:loud/util/magic.dart';

class Cellularizer extends SeededProvider {
  final NoisePlane generator;

  Cellularizer({required this.generator, required int seed})
      : super(seed: seed);

  @override
  double noise1(double x) {
    return noise2(x, 0);
  }

  @override
  double noise2(double x, double y) {
    int xr = round(x);
    int yr = round(y);

    double distance = 999999;
    int xc = 0, yc = 0;
    for (int xi = xr - 1; xi <= xr + 1; xi++) {
      for (int yi = yr - 1; yi <= yr + 1; yi++) {
        D2 vec = CELL_2D[hash2D(seed, xi, yi) & 255];
        double vecX = xi - x + vec.x;
        double vecY = yi - y + vec.y;
        double newDistance =
            (vecX.abs() + vecY.abs()) + (vecX * vecX + vecY * vecY);

        if (newDistance < distance) {
          distance = newDistance;
          xc = xi;
          yc = yi;
        }
      }
    }

    return generator.noise2(xc.toDouble(), yc.toDouble());
  }

  @override
  double noise3(double x, double y, double z) {
    int xr = round(x);
    int yr = round(y);
    int zr = round(z);
    double distance = 999999;
    int xc = 0, yc = 0, zc = 0;
    for (int xi = xr - 1; xi <= xr + 1; xi++) {
      for (int yi = yr - 1; yi <= yr + 1; yi++) {
        for (int zi = zr - 1; zi <= zr + 1; zi++) {
          D3 vec = CELL_3D[hash3D(seed, xi, yi, zi) & 255];
          double vecX = xi - x + vec.x;
          double vecY = yi - y + vec.y;
          double vecZ = zi - z + vec.z;
          double newDistance = (vecX.abs() + vecY.abs() + vecZ.abs()) +
              (vecX * vecX + vecY * vecY + vecZ * vecZ);

          if (newDistance < distance) {
            distance = newDistance;
            xc = xi;
            yc = yi;
            zc = zi;
          }
        }
      }
    }

    return generator.noise3(xc.toDouble(), yc.toDouble(), zc.toDouble());
  }
}
