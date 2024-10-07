import 'package:electrokart/app/modules/checkOutPage/views/check_out_page_view.dart';
import 'package:electrokart/app/utils/colours.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';
import '../controllers/product_description_page_controller.dart';
import 'package:html/parser.dart' as htmlParser;

class ProductDescriptionPageView extends GetView<ProductDescriptionPageController> {
  ProductDescriptionPageView({Key? key}) : super(key: key);

  Widget _buildDescriptionTable(String htmlString) {
    var document = htmlParser.parse(htmlString);

    List<TableRow> rows = document.getElementsByTagName('tr').map((element) {
      List<Widget> cells = element.children.map((child) {
        return TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(child.text),
          ),
        );
      }).toList();

      // Ensure all rows have the same number of cells
      // Fill with empty cells if necessary
      while (cells.length < 2) {
        cells.add(TableCell(child: Container())); // Empty cell
      }

      return TableRow(children: cells);
    }).toList();

    return Table(
      border: TableBorder.all(color: Colors.black),
      children: rows,
    );
  }

  void _handleAddToCart() {
    // Create a PersistentShoppingCartItem for the product

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.lightBlue.shade200,
        shadowColor: Colors.blue.shade200,
        title: const Text(
          'Product Description',
          style: TextStyle(color: appcolor),
        ),
        actions: [
          PersistentShoppingCart().showCartItemCountWidget(
            cartItemCountWidgetBuilder: (itemCount) => IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CheckOutPageView()),
                );
              },
              icon: Badge(
                label: Text(itemCount.toString()),
                child: const Icon(Icons.shopping_bag_outlined),
              ),
            ),
          ),
          const SizedBox(width: 20.0)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(gradient: bg1Gradient),
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: FutureBuilder(
                  future: controller.fetchProducts(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      var products = snapshot.data;
                      if (products != null) {
                        return Column(
                          children: [
                            // Display all product images in a list
                            SizedBox(
                              height: 350,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.product['images']?.length ?? 0,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 5),
                                    child: controller.product['images'][index]['src'] != null
                                        ? Image.network(
                                      controller.product['images'][index]['src'],
                                      fit: BoxFit.contain,
                                    )
                                        : Container(
                                      width: 120,
                                      height: 110,
                                      color: Colors.grey, // Placeholder color or indicator
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 40),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              //height: MediaQuery.of(context).size.height / 2,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20.0),
                                    topLeft: Radius.circular(20.0)),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.product['name'],
                                      style: const TextStyle(fontSize: 14, color: Colors.black),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text(
                                          " ₹${controller.product['regular_price']}",
                                          style: const TextStyle(
                                            decoration: TextDecoration.lineThrough ,
                                              fontSize: 24,
                                              color: Colors.grey,
                                            ),
                                        ),
                                        SizedBox(width: 10,)
                                       , Text(
                                          " ₹${controller.product['price']}",
                                          style: const TextStyle(
                                              fontSize: 24,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        RatingBar.builder(
                                          initialRating: 3,
                                          itemSize: 30,
                                          minRating: 0,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                                          itemBuilder: (context, _) => const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {
                                            print(rating);
                                          },
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: PersistentShoppingCart()
                                              .showAndUpdateCartItemWidget(
                                            inCartWidget: Container(
                                              margin: const EdgeInsets.all(5),
                                              height: 50,
                                              width: MediaQuery.of(context).size.width / 2.5,
                                              decoration: BoxDecoration(
                                                color: appcolor,
                                                borderRadius: BorderRadius.circular(12),
                                                border: Border.all(width: 2, color: Colors.white),
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  'Remove',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                            notInCartWidget: Container(
                                              // margin: const EdgeInsets.all(5),
                                              height: 50,
                                              width: MediaQuery.of(context).size.width / 2.5,
                                              decoration: BoxDecoration(
                                                color: appcolor,
                                                borderRadius: BorderRadius.circular(12),
                                                border: Border.all(width: 2.5, color: Colors.white),
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 5),
                                                child: Center(
                                                  child: Text(
                                                    'Add to cart',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            product: PersistentShoppingCartItem(
                                                productId: controller.toString(),
                                                productName: controller.product['name'],
                                                productDescription: controller.product['description'],
                                                unitPrice: double.parse(
                                                  controller.product['price'] != "" ? controller.product["price"] : '00',
                                                ),
                                                productThumbnail: controller.product['images'] != null &&
                                                    controller.product['images'].isNotEmpty
                                                    ? controller.product['images'][0]['src'] ??
                                                    'https://example.com/placeholder-image.jpg'
                                                    : 'https://example.com/placeholder-image.jpg', // Provide a placeholder URL
                                                quantity: 1),
                                          ),
                                        ),
                                        GestureDetector(
                                         onTap: (){
                                           PersistentShoppingCartItem cartItem = PersistentShoppingCartItem(
                                             productId: controller.toString(),
                                             productName: controller.product['name'],
                                             productDescription: controller.product['description'],
                                             unitPrice: double.parse(controller.product['price'] != "" ? controller.product["price"] : '0'),
                                             productThumbnail: controller.product['images'] != null && controller.product['images'].isNotEmpty
                                                 ? controller.product['images'][0]['src'] ?? 'https://example.com/placeholder-image.jpg'
                                                 : 'https://example.com/placeholder-image.jpg', // Placeholder URL
                                             quantity: 1, // Assuming adding one item to cart initially
                                           );

                                           // Add the item to the cart using PersistentShoppingCart
                                           PersistentShoppingCart().addToCart(cartItem);

                                           // Navigate to the cart page
                                           Navigator.push(
                                             context,
                                             MaterialPageRoute(builder: (context) => CheckOutPageView()),
                                           );
                                         }, child: Container(
                                            // margin: const EdgeInsets.all(8),
                                            height: 50,
                                            width: MediaQuery.of(context).size.width / 2.5,
                                            decoration: BoxDecoration(
                                              color: appcolor,
                                              borderRadius: BorderRadius.circular(12),
                                              border: Border.all(width: 2.5, color: Colors.white),
                                            ),
                                            child: const Center(
                                                child: Text(
                                                  "Buy Now",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold),
                                                )),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      "Description:",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 10),
                                    _buildDescriptionTable(controller.product['description']),
                                    const SizedBox(height: 10),
                                    // const Text("Short Description:",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
                                    // const SizedBox(height: 10,),
                                    _buildDescriptionTable(controller.product['short_description']),
                                    const SizedBox(height: 20),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const Center(child: Text('No products found'));
                      }
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
