import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CounterController extends GetxController {
  var count = 0.obs;
  RxDouble opacity = 0.4.obs;
  var switchValue = false.obs;

  increment() => count.value++;

  setOpacity(double opa) {
    opacity.value = opa;
  }

  switchOnChanged(bool value) {
    switchValue.value = value;
  }

  RxList<dynamic> fruits =
      ["Apple", "Mango", "Dates", "Grapes", "WaterMillon"].obs;
  List<dynamic> favoriteFruits = [].obs;

  setFavorite(String value) {
    if (favoriteFruits.contains(value)) {
      favoriteFruits.remove(value);
    } else {
      favoriteFruits.add(value);
    }
  }

  bool isFavorite(String value) {
    return favoriteFruits.contains(value);
  }
}
