import 'dart:convert';
import 'package:electrokart/app/modules/AccountPage/modals/userDetailModal.dart';
import 'package:electrokart/app/utils/constants.dart';
import 'package:electrokart/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreenController extends GetxController {
late Customer customer;
  //TODO: Implement LoginScreenController
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future setInitialRoute(bool value) async {
    await SharedPreferencesHelper.setLoggedIn(value);
  }

  Future setJwt_token(String value) async {
    await SharedPreferencesHelper.setJwt_token(value);

  }

  Future setUserID(int userId) async {
    await SharedPreferencesHelper.setUserId(userId);
  }


googleLogin() async {
  GoogleSignIn _googleSignIn = GoogleSignIn();
  Get.offNamed('/buttom-bar');
  try {
    var result = await _googleSignIn.signIn();

    if (result != null) {
      // Sign-in successful

      print(result.displayName);
     // return result.id; // Returning the user's ID
    } else {
      // Sign-in failed
      print("Sign-in failed.");
      return null;
    }
  } catch (error) {
    print("Error occurred during Google sign-in: $error");
    return null;
  }
}

Future loginUser(String email, String password) async {
    var headers = {
      'Content-Type': 'application/json',
      'Cookie': 'PHPSESSID=iu8qs5pascftr1frmg3u931bm1; search_suggestions_session_id=64e89692dd87f; tinvwl_wishlists_data_counter=0'
    };
    var request = await http.Request(
        'POST', Uri.parse('https://electrokart.in/wp-json/api/v1/token'));
    request.body = json.encode({"username": email, "password": password});

    request.headers.addAll(headers);
    try {
      http.StreamedResponse response = await request.send();
      print(response.statusCode);
      if (response.statusCode == 200) {
        
        String jwt_tocken = await response.stream.bytesToString();
        Map<String, dynamic> errorData = json.decode(jwt_tocken);
        String errorCode = errorData['jwt_token'];
        storeUserIdInMemory(errorCode);
        setJwt_token(errorCode);
        setInitialRoute(true);
        Get.snackbar("Success", "login SuccessFull",
            backgroundColor: Colors.green, colorText: Colors.white);
        // Get.offNamed(page)
        Get.offNamed('/buttom-bar');
        print(errorCode);
      } else {
        // print(await response.stream.bytesToString());
        String errorMessage = await response.stream.bytesToString();
        Map<String, dynamic> errorData = json.decode(errorMessage);
        String errorCode = errorData['error'];
        Get.snackbar('Error', errorCode,
            backgroundColor: Colors.red.shade400,
            colorText: Colors.white,
            duration: const Duration(seconds: 4),
            messageText: Text(
              errorCode,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ));
      }
    } catch (e) {
      print("ERRRRRRRRRRRRRRRRRRRRRRR$e");
    }
  }
  Future storeUserIdInMemory(String jwt_token) async {
    var headers = {
      'Authorization': 'Bearer $jwt_token',
      'Cookie':
          'PHPSESSID=iu8qs5pascftr1frmg3u931bm1; search_suggestions_session_id=64e89692dd87f; tinvwl_wishlists_data_counter=0'
    };
    var request =
        http.Request('GET', Uri.parse('$baseUrl/wp-json/wp/v2/users/me'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      String userData = await response.stream.bytesToString();
      Map<String, dynamic> userDataMap = json.decode(userData);
      int userId = userDataMap['id'];

      // print(userId);
      setUserID(userId);
      int x = await SharedPreferencesHelper.getUserId();
      print(x);
    } else {
      print(await response.stream.bytesToString());
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
}
