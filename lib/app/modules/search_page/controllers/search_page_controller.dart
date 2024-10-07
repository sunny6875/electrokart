import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
class SearchPageController extends GetxController {
  //TODO: Implement SearchPageController
  var m = '';
  Future search() async {
    List d = Get.arguments;
    String query = d[0];
    print('////////////////////////////////////////');
    print(query);
    var headers = {
      'Cookie': 'PHPSESSID=o00p2cajf9vougr06e43b76m7d; tinvwl_wishlists_data_counter=0'
    };
    var request = http.Request('GET', Uri.parse('https://electrokart.in/wp-json/wc/v3/products?consumer_secret=cs_5094841147a50fc834d7fa843a40e87e772a9228&search=$query& consumer_key=ck_7c45c5f767cedf8a03771d898cd91519f0cca962&status=publish'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;');
      return await response.stream.bytesToString();
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }

  }



  final count = 0.obs;
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

  void increment() => count.value++;
}
