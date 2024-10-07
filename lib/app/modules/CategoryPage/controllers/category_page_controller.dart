import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../modals/product_category.dart';

class CategoryPageController extends GetxController {
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

  @override
  void onInit() {
    super.onInit();
    print("CategoryPageController initialized");
    getCategories();
  }
}




