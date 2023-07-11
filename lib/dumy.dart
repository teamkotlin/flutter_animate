import 'package:flutter/material.dart';
import 'package:flutter_animate/animation_flutterway/screens/home/home_screen.dart';

class DumyScreen extends StatefulWidget {
  const DumyScreen({Key? key}) : super(key: key);

  @override
  State<DumyScreen> createState() => _DumyScreenState();
}

class _DumyScreenState extends State<DumyScreen> {
  _buildRoute() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secAnimation) => HomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          final tween = Tween(begin: begin, end: end);
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: curve,
          );

          return SlideTransition(
            position: tween.animate(curvedAnimation),
            child: child,
          );
        }
        // transitionsBuilder: (context, animation, secAnimation, child) {
        //   const begin = Offset(0.0, 1);
        //   const end = Offset.zero;
        //   var curve = Curves.ease;
        //   var curveTween = CurveTween(curve: curve);
        //   final tween = Tween<Offset>(begin: begin, end: end).chain(curveTween);
        //
        //   final offsetAnimation = animation.drive(tween);
        //   return SlideTransition(
        //     position: offsetAnimation,
        //     child: child,
        //   );
        // },
        );
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
