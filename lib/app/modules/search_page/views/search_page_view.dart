import 'dart:convert';
import 'package:electrokart/app/utils/colours.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/search_page_controller.dart';

class SearchPageView extends GetView<SearchPageController> {
  SearchPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as List;
    final query = args[0] as String;
    final isLogoVisible = args[1] as bool;

    return Scaffold(
      appBar: AppBar(
        title: isLogoVisible
            ? Image.asset("assets/images/logo transparnt bg.png")
            : Image.asset("assets/images/logo transparnt bg.png"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network("https://q-ae.com/assets/imgs/Slider-2.jpg"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0,left: 20),
                child: SizedBox(
                  width: 200,
                  child: Positioned(

                    child: Text(
                      query,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder(
              future: controller.search(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  );
                }
                List<dynamic> data = jsonDecode(snapshot.data.toString());

                if (data.isNotEmpty) {
                  return SizedBox(
                    height: Get.height,
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of items per row
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 0.6, // Adjust as per your design
                      ),
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = data[index];
                        return InkWell(
                          onTap: () {
                            Get.toNamed("/product-description-page", arguments: item['id']);
                          },
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(5.0, 5.0),
                                  blurRadius: 10.0,
                                  spreadRadius: 2.0,
                                ),
                                BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(0.0, 0.0),
                                  blurRadius: 0.0,
                                  spreadRadius: 0.0,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 150, // Adjust the height as needed
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: item['images'].length,
                                      itemBuilder: (context, imageIndex) {
                                        return Container(
                                          margin: const EdgeInsets.symmetric(horizontal: 5),
                                          child: Image.network(
                                            item['images'][imageIndex]['src'] ?? 'https://static.vecteezy.com/system/resources/thumbnails/045/590/065/small_2x/404-error-page-not-found-business-concept-app-screen-modern-screen-template-mobile-app-vector.jpg',
                                            fit: BoxFit.contain,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 15,),
                                  Row(
                                    children: [
                                      Text(
                                        "₹" +item['regular_price'],
                                        style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 15,
                                            decoration:  TextDecoration
                                                .lineThrough,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Text(
                                        "₹" + item['price'],
                                        style: const TextStyle(
                                            color: appcolor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Text(
                                      item['name'],
                                      style: const TextStyle(
                                          color: appcolor, fontSize: 16),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(
                    child: Text(
                      'Product not found',
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
