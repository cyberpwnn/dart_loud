import 'package:loud/interpolator/interpolator.dart';
import 'package:loud/noise/noise_plane.dart';
import 'package:loud/util/magic.dart';

class CubicInterpolator extends Interpolator {
  CubicInterpolator({required NoisePlane input, required double scale})
      : super(input: input, scaleInterpolation: scale);

  @override
  double noise1(double x) {
    List<double> box = getScaleBoundsC1D4(x).map((e) => e.toDouble()).toList();
    return cubic(
        input.noise1(box[X1_D4]),
        input.noise1(box[X2_D4]),
        input.noise1(box[X3_D4]),
        input.noise1(box[X4_D4]),
        normalize(box[X2_D4], box[X3_D4], x));
  }

  @override
  double noise2(double x, double y) {
    List<double> box =
        getScaleBoundsC2D4(x, y).map((e) => e.toDouble()).toList();
    return bicubic(
        input.noise2(box[X1_D4], box[Y1_D4]),
        input.noise2(box[X1_D4], box[Y2_D4]),
        input.noise2(box[X1_D4], box[Y3_D4]),
        input.noise2(box[X1_D4], box[Y4_D4]),
        input.noise2(box[X2_D4], box[Y1_D4]),
        input.noise2(box[X2_D4], box[Y2_D4]),
        input.noise2(box[X2_D4], box[Y3_D4]),
        input.noise2(box[X2_D4], box[Y4_D4]),
        input.noise2(box[X3_D4], box[Y1_D4]),
        input.noise2(box[X3_D4], box[Y2_D4]),
        input.noise2(box[X3_D4], box[Y3_D4]),
        input.noise2(box[X3_D4], box[Y4_D4]),
        input.noise2(box[X4_D4], box[Y1_D4]),
        input.noise2(box[X4_D4], box[Y2_D4]),
        input.noise2(box[X4_D4], box[Y3_D4]),
        input.noise2(box[X4_D4], box[Y4_D4]),
        normalize(box[X2_D4], box[X3_D4], x),
        normalize(box[Y2_D4], box[Y3_D4], y));
  }

  @override
  double noise3(double x, double y, double z) {
    List<double> box =
        getScaleBoundsC3D4(x, y, z).map((e) => e.toDouble()).toList();
    return tricubic(
        input.noise3(box[X1_D4], box[Y1_D4], box[Z1_D4]),
        input.noise3(box[X1_D4], box[Y2_D4], box[Z1_D4]),
        input.noise3(box[X1_D4], box[Y3_D4], box[Z1_D4]),
        input.noise3(box[X1_D4], box[Y4_D4], box[Z1_D4]),
        input.noise3(box[X2_D4], box[Y1_D4], box[Z1_D4]),
        input.noise3(box[X2_D4], box[Y2_D4], box[Z1_D4]),
        input.noise3(box[X2_D4], box[Y3_D4], box[Z1_D4]),
        input.noise3(box[X2_D4], box[Y4_D4], box[Z1_D4]),
        input.noise3(box[X3_D4], box[Y1_D4], box[Z1_D4]),
        input.noise3(box[X3_D4], box[Y2_D4], box[Z1_D4]),
        input.noise3(box[X3_D4], box[Y3_D4], box[Z1_D4]),
        input.noise3(box[X3_D4], box[Y4_D4], box[Z1_D4]),
        input.noise3(box[X4_D4], box[Y1_D4], box[Z1_D4]),
        input.noise3(box[X4_D4], box[Y2_D4], box[Z1_D4]),
        input.noise3(box[X4_D4], box[Y3_D4], box[Z1_D4]),
        input.noise3(box[X4_D4], box[Y4_D4], box[Z1_D4]),
        input.noise3(box[X1_D4], box[Y1_D4], box[Z2_D4]),
        input.noise3(box[X1_D4], box[Y2_D4], box[Z2_D4]),
        input.noise3(box[X1_D4], box[Y3_D4], box[Z2_D4]),
        input.noise3(box[X1_D4], box[Y4_D4], box[Z2_D4]),
        input.noise3(box[X2_D4], box[Y1_D4], box[Z2_D4]),
        input.noise3(box[X2_D4], box[Y2_D4], box[Z2_D4]),
        input.noise3(box[X2_D4], box[Y3_D4], box[Z2_D4]),
        input.noise3(box[X2_D4], box[Y4_D4], box[Z2_D4]),
        input.noise3(box[X3_D4], box[Y1_D4], box[Z2_D4]),
        input.noise3(box[X3_D4], box[Y2_D4], box[Z2_D4]),
        input.noise3(box[X3_D4], box[Y3_D4], box[Z2_D4]),
        input.noise3(box[X3_D4], box[Y4_D4], box[Z2_D4]),
        input.noise3(box[X4_D4], box[Y1_D4], box[Z2_D4]),
        input.noise3(box[X4_D4], box[Y2_D4], box[Z2_D4]),
        input.noise3(box[X4_D4], box[Y3_D4], box[Z2_D4]),
        input.noise3(box[X4_D4], box[Y4_D4], box[Z2_D4]),
        input.noise3(box[X1_D4], box[Y1_D4], box[Z3_D4]),
        input.noise3(box[X1_D4], box[Y2_D4], box[Z3_D4]),
        input.noise3(box[X1_D4], box[Y3_D4], box[Z3_D4]),
        input.noise3(box[X1_D4], box[Y4_D4], box[Z3_D4]),
        input.noise3(box[X2_D4], box[Y1_D4], box[Z3_D4]),
        input.noise3(box[X2_D4], box[Y2_D4], box[Z3_D4]),
        input.noise3(box[X2_D4], box[Y3_D4], box[Z3_D4]),
        input.noise3(box[X2_D4], box[Y4_D4], box[Z3_D4]),
        input.noise3(box[X3_D4], box[Y1_D4], box[Z3_D4]),
        input.noise3(box[X3_D4], box[Y2_D4], box[Z3_D4]),
        input.noise3(box[X3_D4], box[Y3_D4], box[Z3_D4]),
        input.noise3(box[X3_D4], box[Y4_D4], box[Z3_D4]),
        input.noise3(box[X4_D4], box[Y1_D4], box[Z3_D4]),
        input.noise3(box[X4_D4], box[Y2_D4], box[Z3_D4]),
        input.noise3(box[X4_D4], box[Y3_D4], box[Z3_D4]),
        input.noise3(box[X4_D4], box[Y4_D4], box[Z3_D4]),
        input.noise3(box[X1_D4], box[Y1_D4], box[Z4_D4]),
        input.noise3(box[X1_D4], box[Y2_D4], box[Z4_D4]),
        input.noise3(box[X1_D4], box[Y3_D4], box[Z4_D4]),
        input.noise3(box[X1_D4], box[Y4_D4], box[Z4_D4]),
        input.noise3(box[X2_D4], box[Y1_D4], box[Z4_D4]),
        input.noise3(box[X2_D4], box[Y2_D4], box[Z4_D4]),
        input.noise3(box[X2_D4], box[Y3_D4], box[Z4_D4]),
        input.noise3(box[X2_D4], box[Y4_D4], box[Z4_D4]),
        input.noise3(box[X3_D4], box[Y1_D4], box[Z4_D4]),
        input.noise3(box[X3_D4], box[Y2_D4], box[Z4_D4]),
        input.noise3(box[X3_D4], box[Y3_D4], box[Z4_D4]),
        input.noise3(box[X3_D4], box[Y4_D4], box[Z4_D4]),
        input.noise3(box[X4_D4], box[Y1_D4], box[Z4_D4]),
        input.noise3(box[X4_D4], box[Y2_D4], box[Z4_D4]),
        input.noise3(box[X4_D4], box[Y3_D4], box[Z4_D4]),
        input.noise3(box[X4_D4], box[Y4_D4], box[Z4_D4]),
        normalize(box[X2_D4], box[X3_D4], x),
        normalize(box[Y2_D4], box[Y3_D4], y),
        normalize(box[Z2_D4], box[Z3_D4], z));
  }
}
