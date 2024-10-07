import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/return_refund_controller.dart';

class ReturnRefundView extends GetView<ReturnRefundController> {
  const ReturnRefundView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ReturnRefundView'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Image.asset(
                "assets/images/return-box.png",
                height: 60,
                width: 60,
              ),
              const Text(
                "60 DAYS RETURN",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              Image.asset(
                "assets/images/free-shipping.png",
                height: 60,
                width: 60,
              ),
              const Text(
                "FREE SHIPPING",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              const Text(
                "Electrokart Retail",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                  "Puri Complex, Ganesh Bazar, Srinagar Garhwal, Uttarakhand-246174\nelectrokartretail@gmail.com"),
            ],
          ),
        ));
  }
}
