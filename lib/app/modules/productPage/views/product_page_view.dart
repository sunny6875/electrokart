import 'package:electrokart/app/utils/colours.dart';
import 'package:electrokart/provider/favourite_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../../model/productmodel.dart';
import '../controllers/product_page_controller.dart';
import 'package:flutter/material.dart' as flutter;

class ProductPageView extends GetView<ProductPageController> {
  ProductPageView({Key? key}) : super(key: key);
  var id = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(gradient: bg1Gradient),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(Icons.arrow_back),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  const Text(
                    "Products",
                    style: TextStyle(
                        color: appcolor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Get.toNamed('/myfavourite');
                    },
                    child: const Icon(
                      Icons.favorite,
                      size: 30,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: FutureBuilder(
                  future: controller.getProducts(),
                  builder: (context, AsyncSnapshot<List<Product>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator(color: Colors.black));
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                      return const Center(child: Text("No products available"));
                    } else {
                      return GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Number of items per row
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          childAspectRatio: 0.6,
                        ),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          final product = snapshot.data![index];
                          return Consumer<FavouriteItemProvider>(
                              builder: (context, value, child) {
                                return InkWell(
                                  onTap: () {
                                    Get.toNamed("/product-description-page",
                                        arguments: product.id);
                                  },
                                  child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Stack(
                                      children: [
                                        Padding (
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 140,
                                                child: ListView.builder(
                                                  scrollDirection: Axis.horizontal,
                                                  itemCount: product.images.length,
                                                  itemBuilder: (context, imageIndex) {
                                                    return Container(
                                                      height: 40,
                                                      margin: const EdgeInsets.symmetric(horizontal: 5),
                                                      child: flutter.Image.network(
                                                        product.images[imageIndex].src,
                                                        fit: BoxFit.contain,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  const Text(
                                                    "₹",
                                                    style: TextStyle(fontSize: 20),
                                                  ),
                                                  Text(
                                                    product.regularPrice,
                                                    style: const TextStyle(
                                                      decoration:
                                                      TextDecoration.lineThrough,
                                                      color: Colors.grey,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  const Text(
                                                    "₹",
                                                    style: TextStyle(fontSize: 20),
                                                  ),
                                                  Text(
                                                    product.salePrice,
                                                    style: const TextStyle(
                                                      color: appcolor,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Expanded(
                                                child: Text(
                                                  product.name,
                                                  style: const TextStyle(
                                                    color: appcolor,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),

                                            ],

                                          ),
                                        ),
                                        Positioned(
                                          top: 2,
                                          right: 1, child:   IconButton(
                                          onPressed: () {
                                            if (value.isItemSelected(
                                                product.id)) {
                                              value.removeItem(product.id);
                                            } else {
                                              value.addItem(product.id);
                                            }
                                          },
                                          icon: Icon(
                                            value.isItemSelected(product.id)
                                                ? Icons.favorite
                                                : Icons.favorite_border_outlined,
                                            color: value.isItemSelected(product.id)
                                                ? Colors.red
                                                : Colors.black,
                                          ),
                                        ),)
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
