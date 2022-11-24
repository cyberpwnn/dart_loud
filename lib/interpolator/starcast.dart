import 'package:loud/interpolator/interpolator.dart';
import 'package:loud/noise/noise_plane.dart';
import 'package:loud/util/compiled_starcast.dart';

class StarcastInterpolator extends Interpolator {
  final double checks;

  StarcastInterpolator(
      {required this.checks, required NoisePlane input, required double scale})
      : super(input: input, scaleInterpolation: scale);

  @override
  double noise1(double x) => noise2(x, 0);

  @override
  double noise2(double x, double y) =>
      getStarcast(x, y, scaleInterpolation, checks, input);
  @override
  double noise3(double x, double y, double z) => noise2(x, y);
}
