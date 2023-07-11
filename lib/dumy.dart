import 'package:flutter/material.dart';
class DumyScreen extends StatefulWidget {
  const DumyScreen({Key? key}) : super(key: key);

  @override
  State<DumyScreen> createState() => _DumyScreenState();
}

class _DumyScreenState extends State<DumyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: DefaultTextStyle(
        style: TextStyle(color: Colors.teal,fontSize: 16,fontWeight: FontWeight.w500),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SelectionArea(
            child: Column(
              children: [
                Text.rich(TextSpan(text: "Test Span",children: <TextSpan>[
                  TextSpan(text: " Child1 ",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold)),
                  TextSpan(text: "Child2"),
                ])),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
