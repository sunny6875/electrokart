import 'package:cached_network_image/cached_network_image.dart';
import 'package:electrokart/app/modules/checkOutPage/views/check_out_page_view.dart';
import 'package:electrokart/app/utils/colours.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';
import '../controllers/cart_page_controller.dart';
import 'package:flutter/material.dart' as flutter;

class CartPageView extends GetView<CartPageController> {
  const CartPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product Add to Cart',
          style: TextStyle(color: appcolor),
        ),
        actions: [
          PersistentShoppingCart().showCartItemCountWidget(
            cartItemCountWidgetBuilder: (itemCount) => IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CheckOutPageView(),
                  ),
                );
              },
              icon: Badge(
                label: Text(itemCount.toString()),
                child: const Icon(Icons.shopping_bag_outlined),
              ),
            ),
          ),
          const SizedBox(width: 20.0),
        ],
      ),
      body: Obx(
            () {
          if (controller.productList.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return GridView.builder(
              controller: controller.scrollController,
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemCount: controller.productList.length,
              itemBuilder: (context, index) {
                final itemsList = controller.productList;
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              height: 125,
                              child: InkWell(
                                onTap: () => Get.toNamed(
                                  "/product-description-page",
                                  arguments: itemsList[index].id,
                                ),
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: itemsList[index].images.length,
                                  itemBuilder: (context, imageIndex) {
                                    return Container(
                                      height: 40,
                                      margin: const EdgeInsets.symmetric(horizontal: 5),
                                      child: flutter.Image.network(
                                        itemsList[index].images[imageIndex].src,
                                        fit: BoxFit.contain,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "₹${itemsList[index].regularPrice.isNotEmpty ? itemsList[index].regularPrice : itemsList[index].salePrice}",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              "₹${itemsList[index].salePrice.isNotEmpty ? itemsList[index].salePrice : itemsList[index].regularPrice}",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: appcolor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          itemsList[index].name.length > 10
                              ? itemsList[index].name.substring(0, 10)
                              : itemsList[index].name,
                        ),

                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: PersistentShoppingCart()
                                .showAndUpdateCartItemWidget(
                              inCartWidget: Container(
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.black),
                                ),
                                child: Center(
                                  child: Text(
                                    'Remove',
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                ),
                              ),
                              notInCartWidget: Container(
                                height: 30,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.green),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  child: Center(
                                    child: Text(
                                      'Add to cart',
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ),
                                ),
                              ),
                              product: PersistentShoppingCartItem(
                                productId: index.toString(),
                                productName: itemsList[index].name,
                                productDescription: itemsList[index].description,
                                unitPrice: double.parse(
                                  itemsList[index].price.isNotEmpty
                                      ? itemsList[index].price
                                      : '00',
                                ),
                                productThumbnail: itemsList[index].images.isNotEmpty
                                    ? itemsList[index].images[0].src ??
                                    'https://example.com/placeholder-image.jpg'
                                    : 'https://example.com/placeholder-image.jpg',
                                quantity: 1,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class NetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final double width, height, borderRadius, iconSize;

  const NetworkImageWidget({
    Key? key,
    required this.imageUrl,
    this.width = 40,
    this.height = 40,
    this.borderRadius = 18,
    this.iconSize = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        imageBuilder: (context, imageProvider) => Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) => Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: const Padding(
            padding: EdgeInsets.all(12.0),
            child: LoadingWidget(),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(13),
          ),
          child: Icon(
            Icons.error_outline,
            size: iconSize,
          ),
        ),
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  final double size;

  const LoadingWidget({Key? key, this.size = 36.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        strokeWidth: 2.0,
        color: Colors.blue,
      ),
    );
  }
}
