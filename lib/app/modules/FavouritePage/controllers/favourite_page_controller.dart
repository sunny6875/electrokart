import 'dart:convert';
import 'package:electrokart/app/modules/FavouritePage/views/secret.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../model/productmodel.dart';




class FavouritePageController extends GetxController {
  RxList<Product> productList = <Product>[].obs;
  final ScrollController scrollController = ScrollController();
  int currentPage = 1;
  int perPage = 40;

  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_scrollListener);
    loadFavorites().then((favorites) {
      productList.addAll(favorites);
      getProductss();
    });
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
        await saveFavorites(productList);
      } else {
        print('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception while loading products: $e');
    }
    isLoading = false;
  }

  Future<void> saveFavorites(List<Product> products) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> encodedProducts = products.map((product) => json.encode(product)).toList();
    await prefs.setStringList('favorites', encodedProducts);
  }

  Future<List<Product>> loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? encodedProducts = prefs.getStringList('favorites');
    if (encodedProducts != null) {
      return encodedProducts.map((encodedProduct) => Product.fromJson(json.decode(encodedProduct))).toList();
    }
    return [];
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
