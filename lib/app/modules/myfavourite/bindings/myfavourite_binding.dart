import 'package:get/get.dart';

import '../controllers/myfavourite_controller.dart';

class MyfavouriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyfavouriteController>(
      () => MyfavouriteController(),
    );
  }
}
