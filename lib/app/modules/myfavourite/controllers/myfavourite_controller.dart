import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:electrokart/model/productmodel.dart';
import 'package:get/get.dart';
import 'package:electrokart/app/modules/FavouritePage/views/secret.dart';

class MyfavouriteController extends GetxController {
  RxList<Product> productList = <Product>[].obs;
  final ScrollController scrollController = ScrollController();
  int currentPage = 1;
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_scrollListener);
    getProductss();
  }

  void _scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent && !isLoading) {
      getProductss();
    }
  }

  Future<void> getProductss() async {
    if (isLoading) return;
    isLoading = true;
    try {
      final response = await http.get(Uri.parse(
          "https://electrokart.in/wp-json/allproduct/v1/get?consumer_key=ck_7c45c5f767cedf8a03771d898cd91519f0cca962&consumer_secret=cs_5094841147a50fc834d7fa843a40e87e772a9228&per_page=40&page=$currentPage"));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<Product> products = (data['product'] as List)
            .map((productJson) => Product.fromJson(productJson))
            .toList();
        productList.addAll(products);
        currentPage++;
      } else {
        print('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception while loading products: $e');
    }
    isLoading = false;
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
