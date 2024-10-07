import 'package:get/get.dart';

import '../controllers/sub_category_page_controller.dart';

class SubCategoryPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubCategoryPageController>(
      () => SubCategoryPageController(),
    );
  }
}
