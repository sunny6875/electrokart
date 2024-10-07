import 'dart:convert';
import 'package:electrokart/app/utils/constants.dart';
import 'package:electrokart/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SignUpScreenController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController password = TextEditingController();

  //TODO: Implement SignUpScreenController
  var checkBox = false.obs;
  final count = 0.obs;

  final checkboxError = Rxn<String>();

  Future signUpUser(String firstName, String lastName,
      String email, String password) async {

    try {
      var headers = {
        'Content-Type': 'application/json',
        'Cookie':
            'PHPSESSID=bcp9nd8uc4926rlf8mns8g75ld; search_suggestions_session_id=64e89692dd87f; tinvwl_wishlists_data_counter=0'
      };
      var request = await http.Request(
          'POST',
          Uri.parse(
              '$baseUrl/wp-json/wc/v3/customers?consumer_key=$consumerKey&consumer_secret=$secretKey'));
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
          "phone": "(555) 555-5555"
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
      if (response.statusCode == 201) {
        Get.snackbar("Success", "Register SuccessFull",
            backgroundColor: Colors.green, colorText: Colors.white);
           setInitialRoute(true);
        Get.offNamed('/buttom-bar');

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
        // errorMessage = errorMessage['code'];
      }
    } catch (e) {
      print("Errorrrrr ,$e");
    }
  }
  void validateCheckbox(bool? value) {
    if (value == null || !value) {
      checkboxError.value = 'Please agree to terms and conditions';
    } else {
      checkboxError.value = null;
    }
  }

  Future setInitialRoute(bool value) async {
    await SharedPreferencesHelper.setLoggedIn(value);
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
// SizedBox(
// width: MediaQuery.of(context).size.width,
// child: Row(
// children: [
// Obx(
// () => Checkbox(
// checkColor: Colors.white,
// activeColor: appcolor,
// value: controller.checkBox.value,
// onChanged: (bool? value) {
// controller.checkBox.value = value ?? false;
// controller.validateCheckbox(value);
// },
// ),
// ),
// const Text("I agree with our terms and conditions"),
// ],
// ),
// ),
// // Error message for checkbox validation
// if (controller.checkboxError.value != null)