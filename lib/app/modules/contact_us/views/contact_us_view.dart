import 'package:electrokart/app/utils/colours.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/contact_us_controller.dart';

class ContactUsView extends GetView<ContactUsController> {
  const ContactUsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Have a question or feedback? Contact us!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
           const SizedBox(height: 16.0),
           const TextField(
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12.0),
           const TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
           const SizedBox(height: 12.0),
           const TextField(
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12.0),
            const TextField(
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Message',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                var snackBar = const SnackBar(content: Text('successful'),  backgroundColor: Colors.green);
                ScaffoldMessenger.of(context).showSnackBar(snackBar);

              },
              child: SizedBox(height: 70,width: MediaQuery.of(context).size.width,
                  child: const Center(child: Text('Submit',style: TextStyle(color: appcolor,fontSize: 20),))),
            ),
          ],
        ),
      ),
    );
  }
}
