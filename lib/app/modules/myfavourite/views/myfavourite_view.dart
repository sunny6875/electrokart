import 'package:electrokart/app/utils/colours.dart';
import 'package:electrokart/provider/favourite_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as flutter;
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../controllers/myfavourite_controller.dart';

class MyfavouriteView extends GetView<MyfavouriteController> {
  const MyfavouriteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favouriteProvider = Provider.of<FavouriteItemProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        title: Container(
          height: 60,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: white,
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5.0,
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Wishlist",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                InkWell(
                  onTap: () => Get.toNamed('/address'),
                  child: const Text(
                    "+ Add Address",
                    style: TextStyle(color: Color(0xFF275C71), fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(gradient: bg1Gradient),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Obx(() {
                  if (controller.productList.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    var favoriteItems = controller.productList.where(
                            (product) =>
                            favouriteProvider.selectedItems.contains(product.id)).toList();
                    return GridView.builder(
                      controller: controller.scrollController,
                      padding: const EdgeInsets.all(12),
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.6,
                      ),
                      itemCount: favoriteItems.length,
                      itemBuilder: (BuildContext context, int index) {
                        final product = favoriteItems[index];
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
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 140,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: product.images.length,
                                              itemBuilder: (context,
                                                  imageIndex) {
                                                return Container(
                                                  height: 40,
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 5),
                                                  child:
                                                  flutter.Image.network(
                                                    product.images[imageIndex]
                                                        .src,
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
                                              Expanded(
                                                child: Text(
                                                  product.regularPrice
                                                      .isNotEmpty
                                                      ? product.regularPrice
                                                      : product.salePrice,
                                                  style: const TextStyle(
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    color: Colors.grey,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              const Text(
                                                "₹",
                                                style: TextStyle(fontSize: 20),
                                              ),
                                              Text(
                                                product.salePrice.isNotEmpty
                                                    ? product.salePrice
                                                    : product.regularPrice,
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
                                      right: 1,
                                      child: InkWell(
                                        onTap: () {
                                          if (value.isItemSelected(
                                              product.id)) {
                                            value.removeItem(product.id);
                                          } else {
                                            value.addItem(product.id);
                                          }
                                        },
                                          child: Icon(
                                            value.isItemSelected(product.id)
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: value.isItemSelected(
                                                product.id)
                                                ? Colors.red
                                                : Colors.grey,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
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
