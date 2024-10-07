import 'package:get/get.dart';

import '../controllers/buttom_bar_controller.dart';

class ButtomBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ButtomBarController>(
      () => ButtomBarController(),
    );
  }
}
