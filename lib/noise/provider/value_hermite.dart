import 'package:loud/interpolator/interpolator.dart';
import 'package:loud/noise/provider/seeded.dart';

class ValueHermiteProvider extends SeededProvider {
  ValueHermiteProvider({required int seed}) : super(seed: seed);

  @override
  double noise1(double x) {
    int x0 = floor(x);
    int x1 = x0 + 1;
    double xs = 0, ys = 0, zs = 0;
    xs = interpHermiteFunc(x - x0);
    double xf00 = lerp(valCoord1D(seed, x0), valCoord1D(seed, x1), xs);
    double xf10 = lerp(valCoord1D(seed, x0), valCoord1D(seed, x1), xs);
    double xf01 = lerp(valCoord1D(seed, x0), valCoord1D(seed, x1), xs);
    double xf11 = lerp(valCoord1D(seed, x0), valCoord1D(seed, x1), xs);
    double yf0 = lerp(xf00, xf10, ys);
    double yf1 = lerp(xf01, xf11, ys);
    return lerp(yf0, yf1, zs);
  }

  @override
  double noise2(double x, double y) {
    int x0 = floor(x);
    int y0 = floor(y);
    int x1 = x0 + 1;
    int y1 = y0 + 1;
    double xs = 0, ys = 0, zs = 0;
    xs = interpHermiteFunc(x - x0);
    ys = interpHermiteFunc(y - y0);
    double xf00 = lerp(valCoord2D(seed, x0, y0), valCoord2D(seed, x1, y0), xs);
    double xf10 = lerp(valCoord2D(seed, x0, y1), valCoord2D(seed, x1, y1), xs);
    double xf01 = lerp(valCoord2D(seed, x0, y0), valCoord2D(seed, x1, y0), xs);
    double xf11 = lerp(valCoord2D(seed, x0, y1), valCoord2D(seed, x1, y1), xs);
    double yf0 = lerp(xf00, xf10, ys);
    double yf1 = lerp(xf01, xf11, ys);
    return lerp(yf0, yf1, zs);
  }

  @override
  double noise3(double x, double y, double z) {
    int x0 = floor(x);
    int y0 = floor(y);
    int z0 = floor(z);
    int x1 = x0 + 1;
    int y1 = y0 + 1;
    int z1 = z0 + 1;
    double xs = 0, ys = 0, zs = 0;
    xs = interpHermiteFunc(x - x0);
    ys = interpHermiteFunc(y - y0);
    zs = interpHermiteFunc(z - z0);
    double xf00 =
        lerp(valCoord3D(seed, x0, y0, z0), valCoord3D(seed, x1, y0, z0), xs);
    double xf10 =
        lerp(valCoord3D(seed, x0, y1, z0), valCoord3D(seed, x1, y1, z0), xs);
    double xf01 =
        lerp(valCoord3D(seed, x0, y0, z1), valCoord3D(seed, x1, y0, z1), xs);
    double xf11 =
        lerp(valCoord3D(seed, x0, y1, z1), valCoord3D(seed, x1, y1, z1), xs);
    double yf0 = lerp(xf00, xf10, ys);
    double yf1 = lerp(xf01, xf11, ys);
    return lerp(yf0, yf1, zs);
  }
}
