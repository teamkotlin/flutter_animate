import 'package:flutter/material.dart';
import 'package:flutter_animate/animation_flutterway/text_home_screeen.dart';

class DumyScreen extends StatefulWidget {
  const DumyScreen({Key? key}) : super(key: key);

  @override
  State<DumyScreen> createState() => _DumyScreenState();
}

class _DumyScreenState extends State<DumyScreen> {
  Route _buildRoute() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, child) => const TextHomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final tween =
              Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset(0, 0))
                  .chain(CurveTween(curve: Curves.easeInOut));
          final offsetTween = animation.drive(tween);
          final curve = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
          return SlideTransition(position: tween.animate(curve), child: child);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: DefaultTextStyle(
        style: TextStyle(
            color: Colors.teal, fontSize: 16, fontWeight: FontWeight.w500),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SelectionArea(
            child: Column(
              children: [
                Text.rich(TextSpan(text: "Test Span", children: <TextSpan>[
                  TextSpan(
                      text: " Child1 ",
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold)),
                  TextSpan(text: "Child2"),
                ])),
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(_buildRoute());
                    },
                    child: Text("Move to Next!")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
