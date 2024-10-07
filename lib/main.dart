import 'package:electrokart/app/modules/PhonePePayment/controllers/phone_pe_payment_controller.dart';
import 'package:electrokart/provider/favourite_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/routes/app_pages.dart';

void main() async{
  await PersistentShoppingCart().init();
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AppPages.initialRoute,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        return MultiProvider(
            providers: [
           ChangeNotifierProvider(create: (_) => FavouriteItemProvider() )
            ],
        child :GetMaterialApp(

          debugShowCheckedModeBanner: false,
          title: "Application",
          initialRoute: snapshot.data,
          getPages: AppPages.routes,
          defaultTransition: Transition.fade,
          transitionDuration: const Duration(milliseconds: 300),
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          // Define the routes
          unknownRoute: GetPage(
            name: '/not-found',
            page: () => NotFoundPage(),

          ),
        ));
      },
    );
  }
}

class SharedPreferencesHelper {
  static const String _loggedInKey = 'isLoggedIn';

  static const String _jwt_token = 'jwt_token';
  static const String _userId = 'userId';

  static Future<void> setJwt_token(String jwt_token)async{
    final SharedPreferences preferences  = await SharedPreferences.getInstance();
    await preferences.setString(_jwt_token, jwt_token);
  }


  static Future<String> getJwt_token() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_jwt_token) ?? "";
  }

  static Future<void> setUserId(int userId)async{
    final SharedPreferences preferences  = await SharedPreferences.getInstance();
    await preferences.setInt(_userId, userId);
  }
  static Future<int> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_userId) ?? 0;
  }
  static Future<void> setLoggedIn(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loggedInKey, value);
  }

  static Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_loggedInKey) ?? false;
  }
}

class NotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Not Found'),
      ),
      body: const Center(
        child: Text('404 - Page not found'),

      ),
    );
  }
}
