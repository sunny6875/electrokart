import 'package:get/get.dart';

import '../controllers/return_refund_controller.dart';

class ReturnRefundBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReturnRefundController>(
      () => ReturnRefundController(),
    );
  }
}
