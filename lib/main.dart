import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:flutter_animate/Get_X/main_screen.dart';
import 'package:flutter_animate/Get_X/second_screen.dart';
import 'package:flutter_animate/animation/here_screen.dart';
import 'package:flutter_animate/animation/twenn_color_builder.dart';
import 'package:get/get.dart';

import 'Get_X/constants/Languages.dart';
import 'Get_X/counter_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(brightness: Brightness.dark),
      locale: Locale('en', 'US'),
      translations: Languages(),
      fallbackLocale: Locale('en', 'US'),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      home: const MainScreen(),
      getPages: [
        GetPage(name: "/", page: () => const MainScreen()),
        GetPage(name: "/second_page", page: () => const SecondScreen()),
        GetPage(name: "/home", page: () => const HomePage()),
        GetPage(name: "/counter", page: () => const CounterScreen())
      ],
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat();
    _animation = Tween<double>(begin: 0.0, end: 2 * pi).animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Animate'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()..rotateY(_animation.value),
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            offset: const Offset(0, 3),
                            blurRadius: 7,
                            spreadRadius: 5)
                      ]),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
