import 'package:get/get.dart';

import '../controllers/product_description_page_controller.dart';

class ProductDescriptionPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductDescriptionPageController>(
      () => ProductDescriptionPageController(),
    );
  }
}
