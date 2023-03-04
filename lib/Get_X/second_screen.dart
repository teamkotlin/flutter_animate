import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    debugPrint("Locale+=> ${Get.deviceLocale}");
    return Scaffold(
      appBar: AppBar(
        title: Text("${Get.arguments[0]}"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("${Get.arguments[1]}")),
            Text('name'.tr),
            Text('message'.tr),
            TextButton(
                onPressed: () {
                  Get.updateLocale(Locale('ur', 'PK'));
                },
                child: Text("Urdu")),
            TextButton(
                onPressed: () {
                  Get.updateLocale(Locale('en', 'US'));
                },
                child: Text("English")),
          ],
        ),
      ),
    );
  }
}
