import 'dart:developer' as devtools show log;
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../network/api_service.dart';

extension on Object {
  void log() => devtools.log(toString());
}

abstract class CanRun {
  final Type type;
  const CanRun({required this.type});
  // String get type {
  //   if (this is Cat) {
  //     return 'type is Cat';
  //   } else {
  //     return 'Something else';
  //   }
  // }

  @mustCallSuper
  void canRun() {
    'CanRun runs is running'.log();
  }
}
enum Type{
  cat,
  dog
}
class Cat extends CanRun {
  const Cat():super(type: Type.cat);
  @override
  void canRun() {
    super.canRun();
  }
}

abstract class CanWalk{
  canWalk(){
    'can walk...'.log();
  }
}

class Dog extends CanRun {
  const Dog({required super.type});
}

void test() {
  final cat = Cat();
  cat.canRun();
  cat.type.log();

  final dog = Dog(type: Type.dog);
  dog.type.log();
}


class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    test();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          hiveTest();
        },
        child: const Icon(Icons.published_with_changes_sharp),
      ),
      appBar: AppBar(
        title: const Text('Get Tutorial'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FutureBuilder(
              future: Hive.openBox("myBox"),
              builder: (context, snapshot) {
                return Text(
                    "${snapshot.data!.get("details")["level"].toString()}");
              }),
          ElevatedButton(
            onPressed: () async{
              //showSnackBar();
              //showAlertDialog();
              //showGetBottomSheet();
//              nextPage();
            'moving'.log();
            'into data'.log();
            final rp = ReceivePort();
            await Isolate.spawn(ApiService().getData, rp.sendPort);
            "data received".log();
//            debugPrint('rp.first==>${await rp.first}');
            'test'.log();
            'moved'.log();
            },
            child: const Text("Click Me"),
          ),
        ],
      ),
    );
  }

  showSnackBar() {
    Get.snackbar("Title", "Message will be displayed here ....",
        icon: const Icon(
          Icons.heart_broken_outlined,
          color: Colors.red,
        ),
        shouldIconPulse: true);
  }

  showAlertDialog() {
    Get.defaultDialog(
        title: "Tile",
        middleText: "Do you to allow this app to makes changes in your mobile!",
        confirm: TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text("Ok")));
  }

  showGetBottomSheet() {
    Get.bottomSheet(Container(
      color: Colors.white,
      child: Column(
        children: [
          TextButton(
              onPressed: () {
                changeThemeData();
              },
              child: Text("Dark Theme")),
          TextButton(
              onPressed: () {
                changeThemeData();
              },
              child: Text("Light Theme")),
        ],
      ),
    ));
  }

  changeThemeData() {
    Get.back();
    Get.changeTheme(Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
  }

  nextPage() {
    Get.toNamed("/second_page", arguments: ["Get Navigation", "Go Back"]);
  }

  hiveTest() async {
    var box = await Hive.openBox("myBox");
    //box.put("name", "Muhammad Ramzan");
    box.put("details", {"level": "Prov Level"});
    debugPrint("name+=> ${box.get("name")}");
  }
}
