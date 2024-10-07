import 'dart:convert';
import 'package:electrokart/app/modules/AccountPage/modals/userDetailModal.dart';
import 'package:electrokart/app/utils/constants.dart';
import 'package:electrokart/main.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AccountPageController extends GetxController {
  final count = 0.obs;
  Customer? userDetails; // Declare as nullable

  Future<void> setInitialRoute() async {
    await SharedPreferencesHelper.setLoggedIn(false);
    await SharedPreferencesHelper.setUserId(0);
    await SharedPreferencesHelper.setJwt_token('');


  }

  Future<Customer?> getUserDetails() async {
    try {
      int userId = await SharedPreferencesHelper.getUserId();
      var headers = {
        'Cookie':
        'PHPSESSID=iu8qs5pascftr1frmg3u931bm1; search_suggestions_session_id=64e89692dd87f; tinvwl_wishlists_data_counter=0'
      };
      var request = http.Request(
          'GET',
          Uri.parse(
              '$baseUrl/wp-json/wc/v3/customers/$userId?consumer_key=$consumerKey&consumer_secret=$secretKey'));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var jsonData = await response.stream.bytesToString();
        Map<String, dynamic> jsonMap = json.decode(jsonData);
        userDetails = Customer.fromJson(jsonMap);
        print('++++++++++++++++++++++++++++');
        print(userDetails?.billing['phone']); // Check for null before accessing
        return userDetails;
      } else {
        print(response.reasonPhrase);
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  @override
  void onInit() {
    super.onInit();
    getUserDetails();
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
