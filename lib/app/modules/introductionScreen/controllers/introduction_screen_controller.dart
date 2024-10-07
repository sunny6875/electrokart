import 'package:get/get.dart';

class IntroductionScreenController extends GetxController {
  //TODO: Implement IntroductionScreenController
  RxBool isSelected = true.obs;
  final count = 0.obs;


  void increment() => count.value++;
}
