import 'package:get/get.dart';

import '../controllers/phone_pe_payment_controller.dart';

class PhonePePaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PhonePePaymentController>(
      () => PhonePePaymentController(),
    );
  }
}
