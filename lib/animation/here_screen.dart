import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeroScreen extends StatefulWidget {
  const HeroScreen({Key? key}) : super(key: key);

  @override
  State<HeroScreen> createState() => _HeroScreenState();
}

class _HeroScreenState extends State<HeroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Animate'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ListTile(
            onTap: () {
              Get.to(const HeroNextScreen());
            },
            title: const Text("Muhammad Ramzan"),
            subtitle: const Text("Mobile App Developer"),
            leading: const Hero(
              tag: "myTag",
              child: CircleAvatar(
                child: Image(image: AssetImage("images/logo.png")),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class HeroNextScreen extends StatefulWidget {
  const HeroNextScreen({Key? key}) : super(key: key);

  @override
  State<HeroNextScreen> createState() => _HeroNextScreenState();
}

class _HeroNextScreenState extends State<HeroNextScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Hero(
              flightShuttleBuilder: (flightContext, animation, flightDirection,
                  fromHeroContext, toHeroContext) {
                switch (flightDirection) {
                  case HeroFlightDirection.push:
                    return ScaleTransition(
                      scale: animation.drive(Tween<double>(begin: 0.0, end: 0.0)
                          .chain(CurveTween(curve: Curves.bounceInOut))),
                      child: Material(
                        child: toHeroContext.widget,
                      ),
                    );
                    break;
                  case HeroFlightDirection.pop:
                    return Material(
                      child: fromHeroContext.widget,
                    );
                    break;
                }
              },
              tag: "myTag",
              child: const CircleAvatar(
                  child: Image(image: AssetImage("images/logo.png"))))),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 40,
          ),
          ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Move Back'))
        ],
      ),
    );
  }
}
