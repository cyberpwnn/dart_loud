class MirroredDoubleCache {
  final List<double> cache;
  final int width;
  final int height;

  MirroredDoubleCache({required this.width, required this.height})
      : cache = List.filled(width * height, 0.0);

  int zigZag(int coord, int size) {
    if (coord < 0) {
      coord = coord.abs();
    }

    if (coord % (size * 2) >= size) {
      return (size) - (coord % size) - 1;
    } else {
      return coord % size;
    }
  }

  void set(int x, int y, double v) =>
      cache[(zigZag(y, height) * width) + zigZag(x, width)] = v;

  double get(int x, int y) =>
      cache[(zigZag(y, height) * width) + zigZag(x, width)];
}
