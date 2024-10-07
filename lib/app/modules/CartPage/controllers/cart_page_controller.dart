import 'dart:convert';
import 'package:electrokart/app/modules/FavouritePage/views/secret.dart';
import 'package:electrokart/model/productmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CartPageController extends GetxController {
  final ScrollController scrollController = ScrollController();
  final count = 0.obs;
  RxInt quantity = 0.obs;
  int perPage = 40;
  int currentPage = 1;
  final RxList<Product> productList = <Product>[].obs;

  void _scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      getProductss();
    }
  }

  Future<void> getProductss() async {
    try {
      final response = await http.get(Uri.parse(
          "https://electrokart.in/wp-json/allproduct/v1/get?consumer_key=ck_7c45c5f767cedf8a03771d898cd91519f0cca962&consumer_secret=cs_5094841147a50fc834d7fa843a40e87e772a9228&per_page=$perPage&page=$currentPage"));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<Product> products = (data['product'] as List)
            .map((productJson) => Product.fromJson(productJson))
            .toList();

        productList.addAll(products);
        currentPage++; // Increment current page for next request
      } else {
        print('Failed to load categories: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception while loading categories: $e');
    }
  }

  void incrementQuantity() {
    quantity++;
  }

  void decrementQuantity() {
    if (quantity > 0) {
      quantity--;
    }
  }

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_scrollListener);
    getProductss(); // Initial load
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void increment() => count.value++;
}
