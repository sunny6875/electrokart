import 'dart:convert';
import 'package:electrokart/model/productmodel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProductPageController extends GetxController {
  var id = Get.arguments;
  final count = 0.obs;
  RxInt quantity = 0.obs;
  List<Product> subProduct = [];
  void incrementQuantity() {
    quantity++;
  }

  // Method to decrement quantity
  void decrementQuantity() {
    if (quantity > 0) {
      quantity--;
    }
  }
  Future<List<Product>> getProducts() async {
    try {
      final response = await http.get(Uri.parse(
          "https://electrokart.in/wp-json/allproduct/v1/get?consumer_key=ck_7c45c5f767cedf8a03771d898cd91519f0cca962&consumer_secret=cs_5094841147a50fc834d7fa843a40e87e772a9228&per_page=100&page=1"));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<Product> products = (data['product'] as List)
            .map((productJson) => Product.fromJson(productJson))
            .toList();

        for (int i = 0; i < products.length; i++) {
          for (int j = 0; j < products[i].categories.length; j++) {
            if (id == products[i].categories[j].id) {
              subProduct.add(products[i]);
            }
          }
        }
        return subProduct;
      } else {
        print('Failed to load products: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Exception while loading products: $e');
      return [];
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
