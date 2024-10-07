import 'dart:convert';
import 'package:electrokart/app/modules/AccountPage/modals/userDetailModal.dart';
import 'package:electrokart/app/utils/constants.dart';
import 'package:electrokart/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AddressController extends GetxController {
  final count = 0.obs;
  late Customer userDetails;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController name = TextEditingController(); // Added TextEditingController

  Future<void> setInitialRoute(bool value) async {
    await SharedPreferencesHelper.setLoggedIn(value);
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
        print(userDetails.billing?['phone']); // Added null-aware operator
        return userDetails;
      } else {
        print(response.reasonPhrase);
        return null;
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<void> getAddress(String email, String address, String name, String city ) async {
    try {
      int userId = await SharedPreferencesHelper.getUserId();
      var headers = {
        'Content-Type': 'application/json',
        'Cookie':
        'PHPSESSID=q01r9qanr50d84sop1r1o98q7s; search_suggestions_session_id=64e89692dd87f; tinvwl_wishlists_data_counter=0'
      };
      var requestBody = json.encode({
        "billing": {
          "city": city,
          "first_name": name,
          "email": email,
          "address_1": address
        }
      });
      var apiUrl =
          'https://electrokart.in/wp-json/wc/v3/customers/$userId?consumer_key=ck_7c45c5f767cedf8a03771d898cd91519f0cca962&consumer_secret=cs_5094841147a50fc834d7fa843a40e87e772a9228';
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: requestBody,
      );

      if (response.statusCode == 200) {
        print("Address updated successfully");
        Get.snackbar("Success", "Address updated successfully",
            backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        print("Failed to update address: ${response.reasonPhrase}");
        Get.snackbar("Error", "Failed to update address: ${response.reasonPhrase}",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (error) {
      print("Error updating address: $error");
      Get.snackbar("Error", "Error updating address: $error",
          backgroundColor: Colors.red, colorText: Colors.white);
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

  void increment() => count.value++;
}
