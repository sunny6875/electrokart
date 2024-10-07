import 'dart:convert';
import 'package:electrokart/model/productmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:electrokart/app/modules/CategoryPage/modals/product_category.dart';

class HomePageController extends GetxController {
  late List<Subcategory> subcategories;
  int currentPage = 1;
  int perPage = 40;
  int totalPages = 2;
  ScrollController _scrollController = ScrollController();

  Future Search() async {
    var headers = {
      'Cookie':
          'PHPSESSID=ilh824j51f29l9tfuoeg7h869q; search_suggestions_session_id=64e89692dd87f; tinvwl_wishlists_data_counter=0'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://electrokart.in/wp-json/wc/v3/products?consumer_secret=cs_5094841147a50fc834d7fa843a40e87e772a9228&search=& consumer_key=ck_7c45c5f767cedf8a03771d898cd91519f0cca962'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<List<Categorymodel>> getCategories() async {
    try {
      final response = await http.get(Uri.parse(
          "https://electrokart.in/wp-json/subcategories/v1/categories?consumer_key=ck_7c45c5f767cedf8a03771d898cd91519f0cca962&consumer_secret=cs_5094841147a50fc834d7fa843a40e87e772a9228&per_page=10&page=2"));

      if (response.statusCode == 200) {

        final data = jsonDecode(response.body);
        final List<Categorymodel> categories = (data['categories'] as List)
            .map((categoryJson) => Categorymodel.fromJson(categoryJson))
            .toList();
        // final List<Subcategory> subCategories = (data['categories'][0]['subcategory'] as List)
        //     .map((categoryJson) => Subcategory.fromJson(categoryJson))
        //     .toList();
        List sub= [];
        sub = categories[1].subcategories;
        // for(int i= 0; i<categories[1].subcategories.length;i++){
        //   sub.add(categories[1].subcategories);
        //   print(categories[1].subcategories.length);
        print('ooooooooooooooooooooooooooooooooooooooo');
        //
        //   print(sub);
        // }
        // print(categories);
        return categories;
      } else {
        // Handle error response
        print('Failed to load categories: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      // Handle exceptions
      print('Exception while loading categories: $e');
      return [];
    }
  }
  List<Product> subProduct = [];
  var id = Get.arguments;

  Future<List<Product>> getProductss() async {
    try {
      final response = await http.get(Uri.parse(
          "https://electrokart.in/wp-json/allproduct/v1/get?consumer_key=ck_7c45c5f767cedf8a03771d898cd91519f0cca962&consumer_secret=cs_5094841147a50fc834d7fa843a40e87e772a9228&per_page=100&page=1"));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<Product> products = (data['product'] as List)
            .map((productJson) => Product.fromJson(productJson))
            .toList();

        return products;
      } else {
        // Handle error response
        print('Failed to load products: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      // Handle exceptions
      print('Exception while loading products: $e');
      return [];
    }
  }

  Future<void> loadNextPage() async {
    currentPage++; // Increment page number
    List<Product> nextPageProducts = await getProductss();
    // Append the next page products to the existing list
    // Add logic to add nextPageProducts to your existing list of products
  }

  //TODO: Implement HomePageController
  var dropdownvalue = '1234 NW Bobcat Lane, St...'.obs;

  // Define a list of items for the dropdown
  var items = [
    '1234 NW Bobcat Lane, St...',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Load next page when reaching the end of the list
      var controller;
      controller.loadNextPage();
    }
  }

  TextEditingController search = TextEditingController();
  var qrCode = "".obs;
  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _scrollController.addListener(_scrollListener);
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
