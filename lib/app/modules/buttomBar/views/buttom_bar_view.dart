import 'package:electrokart/app/modules/AccountPage/views/account_page_view.dart';
import 'package:electrokart/app/modules/CartPage/views/cart_page_view.dart';
import 'package:electrokart/app/modules/CategoryPage/views/category_page_view.dart';
import 'package:electrokart/app/modules/FavouritePage/views/favourite_page_view.dart';
import 'package:electrokart/app/modules/HomePage/views/home_page_view.dart';
import 'package:electrokart/app/utils/colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:get/get.dart';
import '../controllers/buttom_bar_controller.dart';

class ButtomBarView extends GetView<ButtomBarController> {
  ButtomBarView({Key? key}) : super(key: key);
  static List pages = [
     HomePageView(),

    CategoryPageView(name: '',),
    CartPageView(),
     FavouritePageView(),
    const AccountPageView()
  ];
  ShapeBorder? bottomBarShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
  );
  SnakeShape snakeShape = SnakeShape.indicator;
  bool showSelectedLabels = true;
  bool showUnselectedLabels = true;
  Color selectedColor = appcolor;
  Color unselectedColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => pages.elementAt(controller.selectedindex.value)),
      bottomNavigationBar:
      Obx(() => SnakeNavigationBar.color(
        height: 65,
        backgroundColor: Colors.white,
        snakeShape: snakeShape,
        shape: bottomBarShape,
        snakeViewColor: appcolor,
        selectedItemColor:
        snakeShape == SnakeShape.indicator ? selectedColor : null,
        unselectedItemColor: unselectedColor,
        showUnselectedLabels: showUnselectedLabels,
        showSelectedLabels: showSelectedLabels,
        currentIndex: controller.selectedindex.value,
        onTap: (index) {
          controller.selectedindex.value = index;
        },
        items:  const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.vertical_split, size: 27), label: 'Category'),
          BottomNavigationBarItem(
              icon: Icon(Icons.production_quantity_limits, size: 27), label: 'Product'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                size: 27,
              ),
              label: 'Wishlist'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 27,
              ),
              label: 'Account')
        ],
        selectedLabelStyle: const TextStyle(fontSize: 14),
        unselectedLabelStyle: const TextStyle(fontSize: 11),
      ),)

    );
  }
}
