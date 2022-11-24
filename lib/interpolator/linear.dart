import 'package:loud/interpolator/interpolator.dart';
import 'package:loud/noise/noise_plane.dart';
import 'package:loud/util/magic.dart';

class LinearInterpolator extends Interpolator {
  LinearInterpolator({required NoisePlane input, required double scale})
      : super(input: input, scaleInterpolation: scale);

  @override
  double noise1(double x) {
    List<double> box = getScaleBoundsC1D2(x).map((e) => e.toDouble()).toList();
    return lerp(input.noise1(box[X1_D2]), input.noise1(box[X2_D2]),
        normalize(box[X1_D2], box[X2_D2], x));
  }

  @override
  double noise2(double x, double y) {
    List<double> box =
        getScaleBoundsC2D2(x, y).map((e) => e.toDouble()).toList();
    return blerp(
        input.noise2(box[X1_D2], box[Y1_D2]),
        input.noise2(box[X2_D2], box[Y1_D2]),
        input.noise2(box[X1_D2], box[Y2_D2]),
        input.noise2(box[X2_D2], box[Y2_D2]),
        normalize(box[X1_D2], box[X2_D2], x),
        normalize(box[Y1_D2], box[Y2_D2], y));
  }

  @override
  double noise3(double x, double y, double z) {
    List<double> box =
        getScaleBoundsC3D2(x, y, z).map((e) => e.toDouble()).toList();
    return trilerp(
        input.noise3(box[X1_D2], box[Y1_D2], box[Z1_D2]),
        input.noise3(box[X2_D2], box[Y1_D2], box[Z1_D2]),
        input.noise3(box[X1_D2], box[Y2_D2], box[Z1_D2]),
        input.noise3(box[X2_D2], box[Y2_D2], box[Z1_D2]),
        input.noise3(box[X1_D2], box[Y1_D2], box[Z2_D2]),
        input.noise3(box[X2_D2], box[Y1_D2], box[Z2_D2]),
        input.noise3(box[X1_D2], box[Y2_D2], box[Z2_D2]),
        input.noise3(box[X2_D2], box[Y2_D2], box[Z2_D2]),
        normalize(box[X1_D2], box[X2_D2], x),
        normalize(box[Y1_D2], box[Y2_D2], y),
        normalize(box[Z1_D2], box[Z2_D2], z));
  }
}
