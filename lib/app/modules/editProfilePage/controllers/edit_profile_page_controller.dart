import 'dart:convert';
import 'package:electrokart/app/modules/AccountPage/modals/userDetailModal.dart';
import 'package:electrokart/app/utils/constants.dart';
import 'package:electrokart/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
class EditProfilePageController extends GetxController {
  //TODO: Implement EditProfilePageController

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController password = TextEditingController(); TextEditingController datemodified = TextEditingController();

  Future<void> Update(String firstName, String lastName, String email,String mobile, String password) async {
    int userId = await SharedPreferencesHelper.getUserId();
    var headers = {
      'Content-Type': 'application/json',
      'Cookie': 'PHPSESSID=cevgor8vmssf0uqdfdlcp4lhbp; tinvwl_wishlists_data_counter=0'
    };
    var request = http.Request('POST', Uri.parse('https://electrokart.in/wp-json/wc/v3/customers/$userId?consumer_key=ck_7c45c5f767cedf8a03771d898cd91519f0cca962&consumer_secret=cs_5094841147a50fc834d7fa843a40e87e772a9228'));
    request.body = json.encode({
      "email": email,
      "first_name": firstName,
      "last_name": lastName,
      "password": password,
      "billing": {
        "first_name": firstName,
        "last_name": lastName,
        "company": "",
        "address_1": "",
        "address_2": "",
        "city": "",
        "state": "",
        "postcode": "",
        "country": "",
        "email": email,
        "phone": mobile
      },
      "shipping": {
        "first_name": firstName,
        "last_name": lastName,
        "company": "",
        "address_1": "",
        "address_2": "",
        "city": "",
        "state": "",
        "postcode": "",
        "country": ""
      }
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      Get.snackbar("Success", "Profile updated successfully",
          backgroundColor: Colors.green, colorText: Colors.white);
    }
    else {
      print(response.reasonPhrase);
      String errorMessage = await response.stream.bytesToString();
      Map<String, dynamic> errorData = json.decode(errorMessage);
      String errorCode = errorData['code'];

      Get.snackbar('Error', errorCode,
          backgroundColor: Colors.red.shade400,
          colorText: Colors.white,
          duration: const Duration(seconds: 6),
          messageText: Text(
            errorCode,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ));
    }
  }

  Future<void> Delete(String firstName, String lastName, String email, String password, String mobile) async {
    int userId = await SharedPreferencesHelper.getUserId();
    try {
      var headers = {
          // 'Content-Type': 'application/json',
          // 'Cookie': 'PHPSESSID=bcp9nd8uc4926rlf8mns8g75ld; search_suggestions_session_id=64e89692dd87f; tinvwl_wishlists_data_counter=0'
      };

      var request = http.Request(
        'POST',
        Uri.parse('https://electrokart.in/wp-json/wc/v3/customers/$userId?consumer_key=ck_7c45c5f767cedf8a03771d898cd91519f0cca962&consumer_secret=cs_5094841147a50fc834d7fa843a40e87e772a9228'),
      );
      //request.headers.addAll(headers);
      request.body = json.encode({
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "username": email,
        "password": password,
        "billing": {
          "first_name": firstName,
          "last_name": lastName,
          "company": "",
          "address_1": "",
          "address_2": "",
          "city": "",
          "state": "",
          "postcode": "",
          "country": "",
          "email": email,
          "phone": mobile,
        },
        "shipping": {
          "first_name": firstName,
          "last_name": lastName,
          "company": "",
          "address_1": "",
          "address_2": "",
          "city": "",
          "state": "",
          "postcode": "",
          "country": ""
        }
      });

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        Get.snackbar("Success", "Profile delete successfully",
            backgroundColor: Colors.red, colorText: Colors.white);
        // Perform any necessary actions after successful update
      } else {
        String errorMessage = await response.stream.bytesToString();
        Map<String, dynamic> errorData = json.decode(errorMessage);
        String errorCode = errorData['code'];

        Get.snackbar('Error', errorCode,
            backgroundColor: Colors.red.shade400,
            colorText: Colors.white,
            duration: const Duration(seconds: 6),
            messageText: Text(
              errorCode,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ));
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future setInitialRoute(bool value) async {
    await SharedPreferencesHelper.setLoggedIn(value);
  }

  late Customer userDetails;
  Future<Customer?> getUserDetails() async {
    int userId = await SharedPreferencesHelper.getUserId();
    var headers = {
      'Cookie':
      'PHPSESSID=iu8qs5pascftr1frmg3u931bm1; search_suggestions_session_id=64e89692dd87f; tinvwl_wishlists_data_counter=0'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://electrokart.in/wp-json/wc/v3/customers/$userId?consumer_key=ck_7c45c5f767cedf8a03771d898cd91519f0cca962&consumer_secret=cs_5094841147a50fc834d7fa843a40e87e772a9228'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonData = await response.stream.bytesToString();
      Map<String, dynamic> jsonMap = json.decode(jsonData);
      userDetails = Customer.fromJson(jsonMap);

      return userDetails;
      print(userDetails.billing['phone']);
    } else {
      print(response.reasonPhrase);
      return null;
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
