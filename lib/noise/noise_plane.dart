import 'package:loud/interpolator/cubic.dart';
import 'package:loud/interpolator/hermite.dart';
import 'package:loud/interpolator/linear.dart';
import 'package:loud/interpolator/starcast.dart';
import 'package:loud/noise/provider/cellularizer.dart';
import 'package:loud/noise/provider/exponent.dart';
import 'package:loud/noise/provider/fitted.dart';
import 'package:loud/noise/provider/octave.dart';
import 'package:loud/noise/provider/scaled.dart';
import 'package:loud/noise/provider/warped.dart';

class NoisePlane {
  double noise1(double x) => noise3(x, 0, 0);

  double noise2(double x, double y) => noise3(x, y, 0);

  double noise3(double x, double y, double z) => 0;

  double getMaxOutput() => 1;

  double getMinOutput() => -1;

  CubicInterpolator cubic(double scale) {
    return CubicInterpolator(
      input: this,
      scale: scale,
    );
  }

  HermiteInterpolator hermite(double scale) {
    return HermiteInterpolator(
      input: this,
      scale: scale,
    );
  }

  LinearInterpolator linear(double scale) {
    return LinearInterpolator(
      input: this,
      scale: scale,
    );
  }

  StarcastInterpolator starcast(double scale, double checks) {
    return StarcastInterpolator(
      input: this,
      scale: scale,
      checks: checks,
    );
  }

  StarcastInterpolator starcast9(double scale) {
    return StarcastInterpolator(
      input: this,
      scale: scale,
      checks: 9,
    );
  }

  NoisePlane cellularize(int seed) {
    return Cellularizer(
      generator: this,
      seed: seed,
    );
  }

  NoisePlane octave(int octaves, double gain) {
    return OctaveProvider(generator: this, octaves: octaves, gain: gain);
  }

  NoisePlane fit(double min, double max) {
    if (this is FittedProvider) {
      return FittedProvider(
        generator: (this as FittedProvider).generator,
        min: min,
        max: max,
      );
    }
    return FittedProvider(
      generator: this,
      min: min,
      max: max,
    );
  }

  NoisePlane exponent(double exponent) {
    return ExponentProvider(
      generator: this,
      exponentValue: exponent,
    );
  }

  NoisePlane scale(double scale) {
    if (this is ScaledProvider) {
      return ScaledProvider(
        generator: (this as ScaledProvider).generator,
        scaleValue: (this as ScaledProvider).scaleValue * scale,
      );
    }

    return ScaledProvider(
      generator: this,
      scaleValue: scale,
    );
  }

  NoisePlane warp(NoisePlane warp, double scale, double multiplier) {
    return WarpedProvider(
      generator: this,
      warpValue: warp,
      scaleValue: scale,
      multiplier: multiplier,
    );
  }

  void benchmark(String name, double ms) {
    double msb = ms / 3;
    int t = DateTime.now().millisecondsSinceEpoch;
    int d1 = 0;
    int d2 = 0;
    int d3 = 0;
    int n = 0;

    while (DateTime.now().millisecondsSinceEpoch - t < msb) {
      noise1((n++).toDouble());
      d1++;
    }

    t = DateTime.now().millisecondsSinceEpoch;

    while (DateTime.now().millisecondsSinceEpoch - t < msb) {
      noise2((n++).toDouble(), (n++).toDouble());
      d2++;
    }

    t = DateTime.now().millisecondsSinceEpoch;

    while (DateTime.now().millisecondsSinceEpoch - t < msb) {
      noise3((n++).toDouble(), (n++).toDouble(), (n++).toDouble());
      d3++;
    }

    print(name +
        ": " +
        "1D: " +
        (d1 / msb).round().toString() +
        "/ms " +
        "2D: " +
        (d2 / msb).round().toString() +
        "/ms " +
        "3D: " +
        (d3 / msb).round().toString() +
        "/ms");
  }
}
