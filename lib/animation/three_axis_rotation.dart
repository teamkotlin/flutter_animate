import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as m;
import 'package:vector_math/vector_math_64.dart';

class ThreeAxisRotation extends StatefulWidget {
  const ThreeAxisRotation({Key? key}) : super(key: key);

  @override
  State<ThreeAxisRotation> createState() => _ThreeAxisRotationState();
}

class _ThreeAxisRotationState extends State<ThreeAxisRotation>
    with TickerProviderStateMixin {
  late AnimationController _xController;
  late AnimationController _yController;
  late AnimationController _zController;
  late Tween<double> _animation;

  @override
  void initState() {
    super.initState();
    _xController =
        AnimationController(vsync: this, duration: const Duration(seconds: 20));
    _yController =
        AnimationController(vsync: this, duration: const Duration(seconds: 30));
    _zController =
        AnimationController(vsync: this, duration: const Duration(seconds: 40));
    _animation = Tween<double>(begin: 0.0, end: 2 * pi);
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    _zController.dispose();
    super.dispose();
  }

  final double _width = 100.0;

  @override
  Widget build(BuildContext context) {
    _xController
      ..reset()
      ..forward();
    _yController
      ..reset()
      ..forward();
    _zController
      ..reset()
      ..forward();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Animate'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 200,
            ),
            AnimatedBuilder(
              builder: (context, child) {
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..rotateX(_animation.evaluate(_xController))
                    ..rotateY(_animation.evaluate(_yController))
                    ..rotateZ(_animation.evaluate(_zController)),
                  child: Stack(
                    children: [
                      //back
                      Transform(
                        transform: Matrix4.identity()
                          ..translate(Vector3(0, 0, _width)),
                        alignment: Alignment.center,
                        child: Container(
                          height: _width,
                          width: _width,
                          color: m.Colors.purple,
                        ),
                      ),
                      //left
                      Transform(
                        transform: Matrix4.identity()..rotateY(-pi / 2),
                        alignment: Alignment.centerLeft,
                        child: Container(
                          height: _width,
                          width: _width,
                          color: m.Colors.green,
                        ),
                      ),
                      //right
                      Transform(
                        transform: Matrix4.identity()..rotateY(pi / 2),
                        alignment: Alignment.centerRight,
                        child: Container(
                          height: _width,
                          width: _width,
                          color: m.Colors.blue,
                        ),
                      ),
                      //front
                      Container(
                        height: _width,
                        width: _width,
                        color: m.Colors.red,
                      ),
                      //top
                      Transform(
                        transform: Matrix4.identity()..rotateX(pi / 2),
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: _width,
                          width: _width,
                          color: m.Colors.brown,
                        ),
                      ),
                      //bottom
                      Transform(
                        transform: Matrix4.identity()..rotateX(pi / 2),
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: _width,
                          width: _width,
                          color: m.Colors.orange,
                        ),
                      ),
                    ],
                  ),
                );
              },
              animation:
                  Listenable.merge([_xController, _yController, _zController]),
            )
          ],
        ),
      ),
    );
  }
}
