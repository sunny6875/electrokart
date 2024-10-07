import 'dart:developer';
import 'package:electrokart/app/modules/CartPage/views/cart_page_view.dart';
import 'package:electrokart/app/utils/colours.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

import '../../PhonePePayment/bindings/newphone.dart';

class CheckOutPageView extends StatefulWidget {
  const CheckOutPageView({Key? key}) : super(key: key);

  @override
  State<CheckOutPageView> createState() => _CartViewState();
}

class _CartViewState extends State<CheckOutPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Padding(
        padding: EdgeInsets.only(left: 20),
        child: Text('My Orders'),
      )),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              Expanded(
                child: PersistentShoppingCart().showCartItems(
                  cartTileWidget: ({required data}) =>
                      CartTileWidget(data: data),
                  showEmptyCartMsgWidget: const EmptyCartMsgWidget(),
                ),
              ),
              PersistentShoppingCart().showTotalAmountWidget(
                cartTotalAmountWidgetBuilder: (totalAmount) => Visibility(
                  visible: totalAmount == 0.0 ? false : true,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 22),
                            ),
                            Text(
                              r"₹" + totalAmount.toString(),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 22),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              // Change background color
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                      const EdgeInsets.all(10)),
                              // Change padding
                              textStyle: MaterialStateProperty.all<TextStyle>(
                                  const TextStyle(fontSize: 18)),
                              // Change text style
                              minimumSize: MaterialStateProperty.all<Size>(
                                  const Size(300, 50)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                //side: BorderSide(color: Colors.red)
                              )) // Set minimum size
                              ),
                          onPressed: () {
                            final shoppingCart = PersistentShoppingCart();

                            // Retrieve cart data and total price
                            Map<String, dynamic> cartData =
                                shoppingCart.getCartData();

                            // Extract cart items and total price
                            List<PersistentShoppingCartItem> cartItems =
                                cartData['cartItems'];
                            double totalPrice = cartData['totalPrice'];
                            log('Total Price: ₹totalPrice');
                          },
                          child: InkWell(
                              onTap: () => Get.toNamed('/phone-pe-payment'),
                              child: const Text('Checkout')))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CartTileWidget extends StatelessWidget {
  final PersistentShoppingCartItem data;

  CartTileWidget({Key? key, required this.data}) : super(key: key);

  final PersistentShoppingCart _shoppingCart = PersistentShoppingCart();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      margin: const EdgeInsets.only(bottom: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          NetworkImageWidget(
            borderRadius: 10,
            height: 120,
            width: 80,
            imageUrl: data.productThumbnail ?? '',
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.productName,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: appcolor.withOpacity(0.6)),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        _shoppingCart.incrementCartItemQuantity(data.productId);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Icon(Icons.add),
                      ),
                    ),
                    const SizedBox(width: 7),
                    Text(
                      data.quantity.toString(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(width: 7),
                    InkWell(
                      onTap: () {
                        _shoppingCart.decrementCartItemQuantity(data.productId);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Icon(Icons.remove),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\₹ ${data.unitPrice}",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () async {
                        bool removed =
                            await _shoppingCart.removeFromCart(data.productId);
                        if (removed) {
                          // Handle successful removal
                          showSnackBar(context, removed);
                        } else {
                          // Handle the case where if product was not found in the cart
                        }
                      },
                      child: Container(
                        height: 30,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.red),
                        ),
                        child: Center(
                          child: Text(
                            'Remove',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showSnackBar(BuildContext context, bool removed) {
    final snackBar = SnackBar(
      content: Text(
        removed
            ? 'Product removed from cart.'
            : 'Product not found in the cart.',
      ),
      backgroundColor: removed ? Colors.green : Colors.red,
      duration: const Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

class EmptyCartMsgWidget extends StatelessWidget {
  const EmptyCartMsgWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
        child: SizedBox(
      height: size.height * .7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Your cart is empty'),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                // Navigator.pop(context);
                Get.to(CartPageView());
              },
              child: const Text('Shop now')),
        ],
      ),
    ));
  }
}
