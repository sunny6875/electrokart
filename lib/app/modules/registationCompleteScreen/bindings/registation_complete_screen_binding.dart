import 'package:get/get.dart';

import '../controllers/registation_complete_screen_controller.dart';

class RegistationCompleteScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegistationCompleteScreenController>(
      () => RegistationCompleteScreenController(),
    );
  }
}
