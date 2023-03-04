import 'dart:math' show pi;

import 'package:flutter/material.dart';

class BlueRedCircle extends StatefulWidget {
  const BlueRedCircle({Key? key}) : super(key: key);

  @override
  State<BlueRedCircle> createState() => _BlueRedCircleState();
}

enum CircleSide { left, right }

extension ToPath on CircleSide {
  Path toPath(Size size) {
    var path = Path();
    late Offset offset;
    late bool clockwise;
    switch (this) {
      case CircleSide.left:
        path.moveTo(size.width, 0);
        offset = Offset(size.width, size.height);
        clockwise = false;
        break;
      case CircleSide.right:
        offset = Offset(0, size.height);
        clockwise = true;
        break;
    }
    path.arcToPoint(offset,
        radius: Radius.elliptical(size.width / 2, size.height / 2),
        clockwise: clockwise);
    path.close();
    return path;
  }
}

class HalfCircleClipper extends CustomClipper<Path> {
  final CircleSide side;

  const HalfCircleClipper({required this.side});

  @override
  Path getClip(Size size) => side.toPath(size);

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

extension on VoidCallback {
  Future<void> delayed(Duration duration) async {
    Future.delayed(duration, this);
  }
}

class _BlueRedCircleState extends State<BlueRedCircle>
    with TickerProviderStateMixin {
  late AnimationController _counterClockwiseAnimationController;
  late Animation<double> _counterClockwiseAnimation;

  late AnimationController _flipController;
  late Animation<double> _flipAnimation;

  @override
  void initState() {
    super.initState();
    _counterClockwiseAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _counterClockwiseAnimation = Tween<double>(begin: 0, end: -(pi / 2))
        .animate(CurvedAnimation(
            parent: _counterClockwiseAnimationController,
            curve: Curves.bounceOut));

    _flipController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _flipAnimation = Tween<double>(begin: 0, end: pi).animate(
        CurvedAnimation(parent: _flipController, curve: Curves.bounceOut));

    _counterClockwiseAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _flipAnimation = Tween<double>(
                begin: _flipAnimation.value, end: _flipAnimation.value + pi)
            .animate(CurvedAnimation(
                parent: _flipController, curve: Curves.bounceOut));
        _flipController
          ..reset()
          ..forward();
      }
    });

    _flipController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _counterClockwiseAnimation = Tween<double>(
                begin: _counterClockwiseAnimation.value,
                end: _counterClockwiseAnimation.value + -(pi / 2))
            .animate(CurvedAnimation(
                parent: _counterClockwiseAnimationController,
                curve: Curves.bounceOut));
        _counterClockwiseAnimationController
          ..reset()
          ..forward();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _counterClockwiseAnimationController.dispose();
    _flipController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(
        const Duration(seconds: 1),
        () => _counterClockwiseAnimationController
          ..reset()
          ..forward.delayed(const Duration(seconds: 1)));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Animate'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: AnimatedBuilder(
            animation: _counterClockwiseAnimationController,
            builder: (context, widget) {
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..rotateZ(_counterClockwiseAnimation.value),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedBuilder(
                      animation: _flipController,
                      builder: (context, child) {
                        return Transform(
                          alignment: Alignment.centerRight,
                          transform: Matrix4.identity()
                            ..rotateY(_flipAnimation.value),
                          child: ClipPath(
                            clipper:
                                const HalfCircleClipper(side: CircleSide.left),
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration:
                                  const BoxDecoration(color: Color(0xff0057b7)),
                            ),
                          ),
                        );
                      },
                    ),
                    AnimatedBuilder(
                      animation: _flipController,
                      builder: (context, child) {
                        return Transform(
                          alignment: Alignment.centerLeft,
                          transform: Matrix4.identity()
                            ..rotateY(_flipAnimation.value),
                          child: ClipPath(
                            clipper:
                                const HalfCircleClipper(side: CircleSide.right),
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration:
                                  const BoxDecoration(color: Color(0xffffd700)),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
