import 'package:electrokart/app/modules/HomePage/views/home_page_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ButtomBarController extends GetxController {
  //TODO: Implement ButtomBarController

  var selectedindex = 0.obs;


  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
