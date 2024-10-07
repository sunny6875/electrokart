import 'package:electrokart/app/modules/CategoryPage/modals/product_category.dart';
import 'package:get/get.dart';

class SubCategoryPageController extends GetxController {
  late List<Subcategory> subcategories;
  //TODO: Implement SubCategoryPageController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    subcategories = Get.arguments;
    print(subcategories);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
