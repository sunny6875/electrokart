import 'package:electrokart/app/modules/checkOutPage/views/check_out_page_view.dart';
import 'package:electrokart/app/utils/colours.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';
import '../controllers/order_controller.dart';

class OrderView extends GetView<OrderController> {
  const OrderView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OrderView'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(children: [Expanded(
          child: PersistentShoppingCart().showCartItems(
            cartTileWidget: ({required data}) => CartTileWidget(data: data),
            showEmptyCartMsgWidget: const EmptyCartMsgWidget(),
          ),
        ),
        
            PersistentShoppingCart().showTotalAmountWidget(
            cartTotalAmountWidgetBuilder: (totalAmount) =>
            Visibility(
            visible: totalAmount == 0.0 ? false: true,
            child: Column(
            children: [
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            const Text('Total', style: TextStyle(color: Colors.black , fontSize: 22),),
            Text(r"$"+totalAmount.toString(), style: const TextStyle(color: Colors.black , fontSize: 22),),
            ],
            ),Container(margin: EdgeInsets.all(12),
          height: 60,decoration: BoxDecoration(color: appcolor),)],)
            ))]),
      ));
  }
}
