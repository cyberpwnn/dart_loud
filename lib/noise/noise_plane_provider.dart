import 'package:loud/noise/noise_plane.dart';
import 'package:loud/util/magic.dart';

class NoisePlaneProvider extends NoisePlane {
  int getSeed() => 0;

  double step(double a, double b) => a > b ? 1 : 0;

  bool isFlat() => false;

  bool isScalable() => true;

  int floor(double f) => f >= 0 ? f.toInt() : (f.toInt() - 1);

  int round(double f) => f.round();

  double interpHermiteFunc(double t) => t * t * (3 - 2 * t);

  int hash2D(int seed, int x, int y) {
    int hash = seed;
    hash ^= X_PRIME * x;
    hash ^= Y_PRIME * y;
    hash = hash * hash * hash * 60493;
    hash = (hash >> 13) ^ hash;
    return hash;
  }

  int hash3D(int seed, int x, int y, int z) {
    int hash = seed;
    hash ^= X_PRIME * x;
    hash ^= Y_PRIME * y;
    hash ^= Z_PRIME * z;
    hash = hash * hash * hash * 60493;
    hash = (hash >> 13) ^ hash;
    return hash;
  }

  int hash4D(int seed, int x, int y, int z, int w) {
    int hash = seed;
    hash ^= X_PRIME * x;
    hash ^= Y_PRIME * y;
    hash ^= Z_PRIME * z;
    hash ^= W_PRIME * w;
    hash = hash * hash * hash * 60493;
    hash = (hash >> 13) ^ hash;
    return hash;
  }

  double valCoord1D(int seed, int x) {
    int n = seed;
    n ^= X_PRIME * x;
    return ((n * n * n * 60493) / LONG_MAX_VALUE.toDouble());
  }

  double valCoord2D(int seed, int x, int y) {
    int n = seed;
    n ^= X_PRIME * x;
    n ^= Y_PRIME * y;
    return ((n * n * n * 60493) / LONG_MAX_VALUE.toDouble());
  }

  double valCoord3D(int seed, int x, int y, int z) {
    int n = seed;
    n ^= X_PRIME * x;
    n ^= Y_PRIME * y;
    n ^= Z_PRIME * z;
    return ((n * n * n * 60493) / LONG_MAX_VALUE.toDouble());
  }

  double gradCoord1D(int seed, int x, double xd) {
    int hash = seed;
    hash ^= X_PRIME * x;
    hash = hash * hash * hash * 60493;
    hash = (hash >> 13) ^ hash;
    return xd * GRAD_1D[hash & 2];
  }

  double gradCoord2D(int seed, int x, int y, double xd, double yd) {
    int hash = seed;
    hash ^= X_PRIME * x;
    hash ^= Y_PRIME * y;
    hash = hash * hash * hash * 60493;
    hash = (hash >> 13) ^ hash;
    D2 g = GRAD_2D[hash & 7];
    return xd * g.x + yd * g.y;
  }

  double gradCoord3D(
      int seed, int x, int y, int z, double xd, double yd, double zd) {
    int hash = seed;
    hash ^= X_PRIME * x;
    hash ^= Y_PRIME * y;
    hash ^= Z_PRIME * z;
    hash = hash * hash * hash * 60493;
    hash = (hash >> 13) ^ hash;
    D3 g = GRAD_3D[(hash & 15)];
    return xd * g.x + yd * g.y + zd * g.z;
  }

  int double2Long(double f) => f.toInt();
}
