import 'package:get/get.dart';

import '../controllers/favourite_page_controller.dart';

class FavouritePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavouritePageController>(
      () => FavouritePageController(),
    );
  }
}
