import 'package:get/get.dart';

import '../controllers/check_out_page_controller.dart';

class CheckOutPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckOutPageController>(
      () => CheckOutPageController(),
    );
  }
}
