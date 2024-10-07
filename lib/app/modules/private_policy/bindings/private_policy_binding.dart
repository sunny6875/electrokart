import 'package:get/get.dart';

import '../controllers/private_policy_controller.dart';

class PrivatePolicyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrivatePolicyController>(
      () => PrivatePolicyController(),
    );
  }
}
