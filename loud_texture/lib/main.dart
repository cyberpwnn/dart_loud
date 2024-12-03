import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:loud/loud.dart';

void main() {
  runApp(const LoudViewer());
}

double pixelSize = 1;
double rez = 128;
Size mapSize = Size(rez * pixelSize, rez * pixelSize);

Color Function(double x, double y, double z) sandstoneSmooth() {
  Color a1 = Color(0xFFEDEBCB);
  Color b1 = Color(0xFFD5C496);
  ColorTween t1 = ColorTween(begin: a1, end: b1);
  NoisePlane plate = ValueLinearProvider(seed: 1).scale(0.1).fit(3, 0);
  NoisePlane stc = ValueLinearProvider(seed: 2).fit(1, 0);

  return (x, y, z) {
    return t1.lerp((plate.noise3(x, y, z * 8) + stc.noise3(x, y, z * 3)) / 4)!;
  };
}

Color Function(double x, double y, double z) cobblestone() {
  Color a1 = Color(0xFF686868);
  Color b1 = Color(0xFF8f8f8f);
  ColorTween t1 = ColorTween(begin: a1, end: b1);

  NoisePlane plate = CellularHeightProvider(seed: 5).scale(0.125).fit(0, 1);
  NoisePlane stc = ValueLinearProvider(seed: 2).fit(1, 0);

  int h = 128;

  return (x, y, z) {
    return t1.lerp((pow(plate.noise3(x, y, z * 5), 1.5).toDouble()))!;
  };
}

Color Function(double x, double y, double z) stone() {
  Color a1 = Color(0xFF686868);
  Color b1 = Color(0xFF8f8f8f);
  ColorTween t1 = ColorTween(begin: a1, end: b1);
  NoisePlane plate = ValueLinearProvider(seed: 5).scale(1).fit(2, 0);
  NoisePlane brightness = PerlinProvider(seed: 6).fit(3.5, 0.01).scale(0.5);
  NoisePlane stretch = PerlinProvider(seed: 7).fit(0.0001, 0.05).scale(0.06);
  NoisePlane splat = ValueLinearProvider(seed: 8).fit(0, 1);

  return (x, y, z) {
    return t1.lerp((splat.noise3(x, y, z) +
            pow(plate.noise3(x * (stretch.noise3(x, y, z) + 0.2), y, z),
                    brightness.noise3(x + (z * 10), y, z))
                .toDouble()) /
        3)!;
  };
}

Color Function(double x, double y, double z) dirt() {
  ColorTween c = ColorTween(begin: Color(0xFF593D29), end: Color(0xFFB9855C));
  double dirtGrainChance = 0.011;
  NoisePlane plane = SimplexProvider(seed: 9).fit(0, 1).scale(1);
  NoisePlane brightness = SimplexProvider(seed: 10).fit(2, 0).scale(0.1);
  NoisePlane grain = SimplexProvider(seed: 10).fit(1, 0).scale(0.3);

  return (x, y, z) {
    double n = plane.noise3(x, y, z);

    if (pow(grain.noise2(x, y), 2) > 0.9) {
      return Color(0xFF777777);
    }

    return c.lerp(pow(
            n,
            brightness.noise3(x - (z * 15 * plane.noise2(y / 10, x / 10)),
                y - (z * 15 * plane.noise2(y / 10, x / 10)), z))
        .toDouble())!;
  };
}

class LoudViewer extends StatefulWidget {
  const LoudViewer({Key? key}) : super(key: key);

  @override
  State<LoudViewer> createState() => _LoudViewerState();
}

class _LoudViewerState extends State<LoudViewer>
    with SingleTickerProviderStateMixin {
  late Ticker _ticker;

  @override
  void initState() {
    _ticker = createTicker((elapsed) {
      setState(() {});
    })
      ..start();
    super.initState();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int seed = 12345678;

    Color Function(double x, double y, double z) plane = stone();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Loud'),
        ),
        body: Center(
          child: InteractiveViewer(
            constrained: false,
            minScale: 0.0000001,
            maxScale: 10000000,
            panEnabled: true,
            scaleEnabled: true,
            scaleFactor: kDefaultMouseScrollToScaleFactor * 4.333,
            boundaryMargin: EdgeInsets.all(100),
            child: SizedBox(
              width: mapSize.width * 10,
              height: mapSize.height * 10,
              child: CustomPaint(
                size: mapSize,
                painter: LoudPainter(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoudPainter extends CustomPainter {
  List<Color Function(double x, double y, double z)> fs = [
    //sandstoneSmooth(),
    //cobblestone(),
    stone(),
    dirt()
  ];
  Paint p = Paint()..color = Colors.white;

  LoudPainter();

  void draw(Canvas canvas, Color Function(double x, double y, double z) f,
      int rez, int ox, int oy) {
    double t = DateTime.now().millisecondsSinceEpoch.toDouble() / 3000.0;
    print(t);

    for (int i = 0; i < rez; i++) {
      for (int j = 0; j < rez; j++) {
        double x = i * pixelSize;
        double y = j * pixelSize;
        x += ox;
        y += oy;
        p.color = f(x + 128, y + 128, t);
        canvas.drawRect(
            Rect.fromLTWH(x, y, pixelSize + 0.1, pixelSize + 0.1), p);
      }
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    Random r = Random(12345678);

    //draw(canvas, fs[1], 128, 0, 0);

    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        draw(canvas, fs[r.nextInt(fs.length)], 16, i * 16, j * 16);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
