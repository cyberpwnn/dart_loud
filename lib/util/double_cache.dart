abstract class CacheIndexProvider<T> {
  T provideCacheIndex(int x, int y);
}

class DoubleArrayCacheProvider extends ProvidingArrayCache<double> {
  DoubleArrayCacheProvider(
      {required super.width,
      required super.height,
      required super.provider,
      super.initialValue,
      super.coordinatePlane});
}

class IntArrayCacheProvider extends ProvidingArrayCache<int> {
  IntArrayCacheProvider(
      {required super.width,
      required super.height,
      required super.provider,
      super.initialValue,
      super.coordinatePlane});
}

class ProvidingArrayCache<T> implements ArrayCache<T> {
  final NullableArrayCache<T> _ncache;
  final CacheIndexProvider<T> provider;

  ProvidingArrayCache(
      {required int width,
      required int height,
      required this.provider,
      T? initialValue,
      CacheCoordinatePlane coordinatePlane = CacheCoordinatePlane.normal})
      : _ncache = NullableArrayCache<T>(
            width: width,
            height: height,
            initialValue: initialValue,
            coordinatePlane: coordinatePlane);

  @override
  T get(int x, int y) => _ncache.get(x, y) ?? provider.provideCacheIndex(x, y);

  @override
  void set(int x, int y, T v) => _ncache.set(x, y, v);

  @override
  List<T> get _storage => throw UnimplementedError();

  @override
  CacheCoordinatePlane get coordinatePlane => _ncache.coordinatePlane;

  @override
  int getIndex(int x, int y) => _ncache.getIndex(x, y);

  @override
  int get height => _ncache.height;

  @override
  int get width => _ncache.width;
}

class NullableArrayCache<T> implements ArrayCache<T?> {
  final ArrayCache<T?> _cache;
  final T? initialValue;

  NullableArrayCache(
      {required int width,
      required int height,
      this.initialValue,
      CacheCoordinatePlane coordinatePlane = CacheCoordinatePlane.normal})
      : _cache = ArrayCache<T?>(
            width: width,
            height: height,
            initialValue: initialValue,
            coordinatePlane: coordinatePlane);

  @override
  T? get(int x, int y) => _cache.get(x, y);

  @override
  void set(int x, int y, T? v) => _cache.set(x, y, v);

  @override
  List<T?> get _storage => _cache._storage;

  @override
  CacheCoordinatePlane get coordinatePlane => _cache.coordinatePlane;

  @override
  int getIndex(int x, int y) => _cache.getIndex(x, y);

  @override
  int get height => _cache.height;

  @override
  int get width => _cache.width;
}

enum CacheCoordinatePlane {
  normal,
  mirrored,
}

class ArrayCache<T> {
  final List<T> _storage;
  final CacheCoordinatePlane coordinatePlane;
  final int width;
  final int height;

  ArrayCache(
      {required this.width,
      required this.height,
      required T initialValue,
      this.coordinatePlane = CacheCoordinatePlane.normal})
      : _storage = List.filled(width * height, initialValue);

  int getIndex(int x, int y) {
    switch (coordinatePlane) {
      case CacheCoordinatePlane.normal:
        return ((y % height) * width) + (x % width);
      case CacheCoordinatePlane.mirrored:
        return (_zigZag(y, height) * width) + _zigZag(x, width);
    }
  }

  void set(int x, int y, T v) => _storage[getIndex(x, y)] = v;

  T get(int x, int y) => _storage[getIndex(x, y)];
}

int _zigZag(int coord, int size) {
  if (coord < 0) {
    coord = coord.abs();
  }

  if (coord % (size * 2) >= size) {
    return (size) - (coord % size) - 1;
  } else {
    return coord % size;
  }
}
