import 'package:loud/interpolator/interpolator.dart';
import 'package:loud/noise/provider/seeded.dart';

class PerlinProvider extends SeededProvider {
  PerlinProvider({required int seed}) : super(seed: seed);

  @override
  double noise1(double x) {
    int x0 = floor(x);
    int x1 = x0 + 1;
    double xs;
    double ys = 0;
    double zs = 0;
    xs = interpHermiteFunc(x - x0);
    double xd0 = x - x0;
    double xd1 = xd0 - 1;
    double xf00 =
        lerp(gradCoord1D(seed, x0, xd0), gradCoord1D(seed, x1, xd1), xs);
    double xf10 =
        lerp(gradCoord1D(seed, x0, xd0), gradCoord1D(seed, x1, xd1), xs);
    double xf01 =
        lerp(gradCoord1D(seed, x0, xd0), gradCoord1D(seed, x1, xd1), xs);
    double xf11 =
        lerp(gradCoord1D(seed, x0, xd0), gradCoord1D(seed, x1, xd1), xs);
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
    double xd0 = x - x0;
    double yd0 = y - y0;
    double xd1 = xd0 - 1;
    double yd1 = yd0 - 1;
    double xf00 = lerp(gradCoord2D(seed, x0, y0, xd0, yd0),
        gradCoord2D(seed, x1, y0, xd1, yd0), xs);
    double xf10 = lerp(gradCoord2D(seed, x0, y1, xd0, yd1),
        gradCoord2D(seed, x1, y1, xd1, yd1), xs);
    double xf01 = lerp(gradCoord2D(seed, x0, y0, xd0, yd0),
        gradCoord2D(seed, x1, y0, xd1, yd0), xs);
    double xf11 = lerp(gradCoord2D(seed, x0, y1, xd0, yd1),
        gradCoord2D(seed, x1, y1, xd1, yd1), xs);
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
    double xd0 = x - x0;
    double yd0 = y - y0;
    double zd0 = z - z0;
    double xd1 = xd0 - 1;
    double yd1 = yd0 - 1;
    double zd1 = zd0 - 1;
    double xf00 = lerp(gradCoord3D(seed, x0, y0, z0, xd0, yd0, zd0),
        gradCoord3D(seed, x1, y0, z0, xd1, yd0, zd0), xs);
    double xf10 = lerp(gradCoord3D(seed, x0, y1, z0, xd0, yd1, zd0),
        gradCoord3D(seed, x1, y1, z0, xd1, yd1, zd0), xs);
    double xf01 = lerp(gradCoord3D(seed, x0, y0, z1, xd0, yd0, zd1),
        gradCoord3D(seed, x1, y0, z1, xd1, yd0, zd1), xs);
    double xf11 = lerp(gradCoord3D(seed, x0, y1, z1, xd0, yd1, zd1),
        gradCoord3D(seed, x1, y1, z1, xd1, yd1, zd1), xs);
    double yf0 = lerp(xf00, xf10, ys);
    double yf1 = lerp(xf01, xf11, ys);
    return lerp(yf0, yf1, zs);
  }
}
