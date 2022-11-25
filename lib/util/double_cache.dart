class DoubleCache {
  final List<double> cache;
  final int width;
  final int height;

  DoubleCache({required this.width, required this.height})
      : cache = List.filled(width * height, 0.0);

  void set(int x, int y, double v) =>
      cache[((y % height) * width) + (x % width)] = v;

  double get(int x, int y) => cache[((y % height) * width) + (x % width)];
}
