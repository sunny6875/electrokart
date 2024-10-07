import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductDescriptionPageController extends GetxController {
  var product = {}.obs;
  var id = Get.arguments;
  final count = 0.obs;
  RxInt quantity = 0.obs;
  final List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  void addToCart(Map<String, dynamic> product) {
    _cartItems.add(product);
  }

  void incrementQuantity() {
    quantity++;
  }

  // Method to decrement quantity
  void decrementQuantity() {
    if (quantity > 0) {
      quantity--;
    }
  }

  Future<Map> fetchProducts() async {
    try {
      var response = await http.get(Uri.parse(
          "https://electrokart.in/wp-json/wc/v3/products/$id?per_page=100&page=1&consumer_key=ck_7c45c5f767cedf8a03771d898cd91519f0cca962&consumer_secret=cs_5094841147a50fc834d7fa843a40e87e772a9228"));

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          final decodedData = jsonDecode(response.body);
          product.value = decodedData;
        }

        return product;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Exception while loading products: $e');
      throw Exception('Failed to load products');
    }
  }
}
