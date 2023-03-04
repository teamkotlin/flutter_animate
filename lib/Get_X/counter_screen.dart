import 'package:flutter/material.dart';
import 'package:flutter_animate/Get_X/controller/CounterController.dart';
import 'package:get/get.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  final CounterController counterController = Get.put(CounterController());

  @override
  Widget build(BuildContext context) {
    debugPrint('build');
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        centerTitle: true,
      ),
      body: Center(
        child: Obx(() => Column(
              children: [
                Text("${counterController.count.value}"),
                Container(
                    height: 200,
                    width: 200,
                    color: Colors.red
                        .withOpacity(counterController.opacity.value)),
                Slider(
                    value: counterController.opacity.value,
                    onChanged: counterController.setOpacity),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Notifications"),
                    Switch(
                        value: counterController.switchValue.value,
                        onChanged: counterController.switchOnChanged)
                  ],
                ),
                Container(
                  height: Get.height * 0.5,
                  child: ListView.builder(
                      itemCount: counterController.fruits.length,
                      itemBuilder: (context, index) {
                        return Obx(() => Card(
                            child: ListTile(
                                onTap: () {
                                  counterController.setFavorite(
                                      counterController.fruits[index]);
                                },
                                title:
                                    Text("${counterController.fruits[index]}"),
                                trailing: Icon(counterController.isFavorite(
                                        counterController.fruits[index]
                                            .toString())
                                    ? Icons.favorite
                                    : Icons.favorite_border))));
                      }),
                ),
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counterController.increment();
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
