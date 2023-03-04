import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    var rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2);
    path.addOval(rect);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class TweenColorBuilder extends StatefulWidget {
  const TweenColorBuilder({Key? key}) : super(key: key);

  @override
  State<TweenColorBuilder> createState() => _TweenColorBuilderState();
}

Color getRandomColor() => Color(0xff000000 + math.Random().nextInt(0x00ffffff));

class _TweenColorBuilderState extends State<TweenColorBuilder> {
  var _color = getRandomColor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Animate'),
        centerTitle: true,
      ),
      body: Center(
        child: ClipPath(
          clipper: CircleClipper(),
          child: TweenAnimationBuilder(
            builder: (context, Color? color, child) {
              return ColorFiltered(
                colorFilter: ColorFilter.mode(color!, BlendMode.srcATop),
                child: child,
              );
            },
            tween: ColorTween(begin: getRandomColor(), end: _color),
            duration: const Duration(seconds: 1),
            onEnd: () {
              setState(() {
                _color = getRandomColor();
              });
            },
            child: Container(
              height: Get.width,
              width: Get.width,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
