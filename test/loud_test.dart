import 'dart:ffi';
import 'dart:isolate';

import 'package:loud/loud.dart';
import 'package:fast_log/fast_log.dart';
import 'package:loud/util/magic.dart';
import 'package:precision_stopwatch/precision_stopwatch.dart';

void main() async {
  // PrecisionStopwatch p = PrecisionStopwatch.start();
  // NoisePlane a = SimplexProvider(seed: 123)
  //     .starcast9(8)
  //     .cached(width: 1024, height: 1024, lazy: true)
  //     .linear(8);
  //
  // NoisePlane b = NoisePlane();
  //
  // NoisePlane plane = PerlinProvider(seed: 1234).scale(0.1);
  //
  // List<double> noise =
  //     List.generate(128, (index) => plane.noise1(index.toDouble()));
  //
  // for (int i = 0; i < 12; i++) {
  //   String l = "";
  //   for (int j = 0; j < noise.length; j++) {
  //     int n = ((noise[j] * 6.0) + 6.0).toInt();
  //     if (n == i) {
  //       l += ".";
  //     } else {
  //       l += " ";
  //     }
  //   }
  //   print(l);
  // }
  //
  // await Future.delayed(Duration(milliseconds: 1));
}
