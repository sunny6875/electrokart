import 'package:electrokart/app/utils/colours.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/category_page_controller.dart';
import '../modals/product_category.dart';

class CategoryPageView extends GetView<CategoryPageController> {
  CategoryPageView({
    Key? key,
    required String name,
  }) : super(key: key);
  int i = 0;

  @override
  Widget build(BuildContext context) {
    print(i++);
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Image.asset("assets/images/logo transparnt bg.png")],
            ),
            FutureBuilder<List<Categorymodel>>(
              future: controller.getCategories(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.black,
                  ));
                }
                if (snapshot.hasData && snapshot.data != null) {
                  List<Categorymodel>? categories = snapshot.data;

                  return Expanded(
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
                          itemCount: categories!.length,
                          itemBuilder: (context, index) {
                            // final subcategory = controller.category.Subcategory[index];

                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(
                                      '/sub-category-page',
                                      arguments:
                                          categories[index].subcategories,
                                    );
                                  },
                                  child: Container(
                                    height: 120,
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade100,
                                          offset: const Offset(
                                            5.0,
                                            5.0,
                                          ),
                                          blurRadius: 8.0,
                                          spreadRadius: 2.0,
                                        ), //BoxShadow
                                        const BoxShadow(
                                          color: Colors.white,
                                          offset: Offset(0.0, 0.0),
                                          blurRadius: 0.0,
                                          spreadRadius: 0.0,
                                        ), //BoxShadow
                                      ],
                                      //border:
                                      // Border.all(color: appcolor, width: 1.5)
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        categories[index].image.isNotEmpty ? categories[index].image
                                : 'https://static.vecteezy.com/system/resources/thumbnails/045/590/065/small_2x/404-error-page-not-found-business-concept-app-screen-modern-screen-template-mobile-app-vector.jpg',

                                        fit: BoxFit.cover,
                                        height: 120,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.5,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  categories[index].name.toString(),
                                  style: const TextStyle(
                                      color: appcolor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            );
                          }));
                  } else if (snapshot.hasError) {
                  print(snapshot.error);
                  return Text('Error: ${snapshot.error}');
                } else {
                  return const Text('No data available');
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
