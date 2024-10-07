import 'package:get/get.dart';

import '../controllers/my_order_page_controller.dart';

class MyOrderPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyOrderPageController>(
      () => MyOrderPageController(),
    );
  }
}
