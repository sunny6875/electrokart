import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';
import '../controllers/phone_pe_payment_controller.dart';

class PhonePePaymentView extends GetView<PhonePePaymentController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PhonePe Payment View'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await controller.startPgTransaction();
              },
              child: Text('Start Transaction'),
            ),
            SizedBox(height: 20),
          SizedBox(height: 400,
                child: Text("Result: ${controller.result}"))
          ],
        ),
      ),
    );
  }
}
