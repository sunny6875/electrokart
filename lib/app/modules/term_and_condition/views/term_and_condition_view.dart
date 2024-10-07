import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/term_and_condition_controller.dart';

class TermAndConditionView extends GetView<TermAndConditionController> {
  const TermAndConditionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Electrokart Terms and Conditions',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'These are the terms and conditions of using the Electrokart app. Please read them carefully before using the app.',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              // Your terms and conditions text here
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. ...',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),SizedBox(height: 30),Text("Electrokart Retail",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),), SizedBox(height: 10),

      Text("Puri Complex, Ganesh Bazar, Srinagar Garhwal, Uttarakhand-246174\nelectrokartretail@gmail.com"),
          ],
        ),
      ),
    );
  }
}
