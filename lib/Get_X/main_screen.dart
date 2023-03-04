import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.published_with_changes_sharp),
      ),
      appBar: AppBar(
        title: const Text('Get Tutorial'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            //showSnackBar();
            //showAlertDialog();
            //showGetBottomSheet();
            nextPage();
          },
          child: const Text("Click Me"),
        ),
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
}
