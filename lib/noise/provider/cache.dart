import 'package:loud/noise/noise_plane.dart';
import 'package:loud/util/double_cache.dart';

class CacheProvider extends NoisePlane {
  late final ProvidingArrayCache<double> cache;

  CacheProvider({
    required int width,
    required int height,
    required NoisePlane generator,
    CacheCoordinatePlane coordinatePlane = CacheCoordinatePlane.normal,
    bool lazy = false,
    double? initialValue,
  }) {
    cache = DoubleArrayCacheProvider(
        width: width,
        height: height,
        provider: this,
        initialValue: initialValue,
        coordinatePlane: coordinatePlane);
    if (!lazy) {
      for (int x = 0; x < width; x++) {
        for (int y = 0; y < height; y++) {
          cache.set(x, y, generator.noise2(x.toDouble(), y.toDouble()));
        }
      }
    }
  }

  @override
  double noise1(double x) {
    return noise2(x, 0);
  }

  @override
  double noise2(double x, double y) {
    try {
      return cache.get(x.toInt(), y.toInt());
    } catch (e) {
      return 0;
    }
  }

  @override
  double noise3(double x, double y, double z) {
    return noise2(x, y == 0 ? z : y);
  }
}
