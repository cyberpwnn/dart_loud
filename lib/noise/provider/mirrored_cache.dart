import 'package:loud/noise/noise_plane.dart';
import 'package:loud/util/mirrored_double_cache.dart';

class MirroredCacheProvider extends NoisePlane {
  late final MirroredDoubleCache cache;

  CacheProvider(
      {required int width,
      required int height,
      required NoisePlane generator}) {
    cache = MirroredDoubleCache(width: width, height: height);
    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
        cache.set(x, y, generator.noise2(x.toDouble(), y.toDouble()));
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
