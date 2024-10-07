import 'dart:convert';
import 'package:electrokart/app/utils/colours.dart';
import 'package:electrokart/model/sub_cat_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart' as flutter;
import '../controllers/sub_category_page_controller.dart';
import 'package:http/http.dart' as http;
class SubCategoryPageView extends GetView<SubCategoryPageController> {
  String name;

  SubCategoryPageView({Key? key, required this.name});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.lightBlue.shade200,
        shadowColor: Colors.blue.shade200,
        title: const Text( "Explore by Categories",
          style:  TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
        ),

      ),
      body: Container(
      //  height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(gradient: bg1Gradient),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Expanded(
               //   height: MediaQuery.of(context).size.height / 1.5,
                  child: GridView.builder(
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns
                        crossAxisSpacing: 20, // Spacing between columns
                        mainAxisSpacing: 20, // Spacing between rows
                        childAspectRatio:
                        0.90, // Aspect ratio of each grid item
                      ),
                      shrinkWrap: true,
                      itemCount: controller.subcategories.length,
                      itemBuilder: (context, index) {
                        // final subcategory = controller.category.Subcategory[index];

                        return InkWell(
                          onTap: () {
                            Get.toNamed('/product-page',arguments: controller.subcategories[index].subcategoryId);
                          },
                          child: Container(
                               height: MediaQuery.of(context).size.height*10,
                            width: MediaQuery.of(context).size.width / 3,
                            decoration: BoxDecoration(
                                color: Colors.white,borderRadius: BorderRadius.circular(8),
                                border:
                                Border.all(color: appcolor, width: 1.5)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                       Image.network(controller.subcategories[index].image.isNotEmpty?controller.subcategories[index].image                                : 'https://static.vecteezy.com/system/resources/thumbnails/045/590/065/small_2x/404-error-page-not-found-business-concept-app-screen-modern-screen-template-mobile-app-vector.jpg',


                         fit:BoxFit.cover,height: 100,width: 200,),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  controller.subcategories[index].name,
                                  style: const TextStyle(color: appcolor,fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        );
                      })),
              const SizedBox(
                height: 20,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
