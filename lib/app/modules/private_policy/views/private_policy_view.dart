import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/private_policy_controller.dart';

class PrivatePolicyView extends GetView<PrivatePolicyController> {
  const PrivatePolicyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Our privacy policy explains what data we collect and how we use it. It also explains how we protect your privacy and your rights regarding your data.',
              style: TextStyle(fontSize: 16.0),
            ),
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

            // Include your privacy policy text here
          ],
        ),
      ),
    );
  }
}
