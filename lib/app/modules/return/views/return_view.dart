import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/return_controller.dart';

class ReturnView extends GetView<ReturnController> {
  const ReturnView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ReturnView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ReturnView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
